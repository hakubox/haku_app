import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:haku_app/config/app_config/index.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:haku_app/utils/tool.dart';
import 'dart:async';
import 'dart:convert';
import 'cache.dart';
import 'package:get/get.dart' as tr;

/// API Key
final String _apiKey = api_key;
/// 默认API版本
const String __apiVersion = '1.0.0';
/// 服务器地址
final String _baseUrl = api_base_url;
// 运道会测试环境： https://sportscircle.api.gejinet.com/api/
// jsonplaceholder： https://jsonplaceholder.typicode.com/

/// HTTP请求内容类型
enum HttpContentType {
  /// JSON类型 'application/json;charset=UTF-8'
  json,
  /// 表单类型 'application/x-www-form-urlencoded'
  form,
  /// 表单文件类型 'multipart/form-data'
  formData,
  /// 文件流类型 'application/octet-stream'
  octetStream
}

/// http请求参数
class HttpOptions {
  /// http参数默认构造器
  const HttpOptions({
    this.data,
    this.query,
    this.method = 'GET',
    this.contentType = HttpContentType.json,
    this.responseType = ResponseType.json,
    this.apiVersion = __apiVersion,
    this.connectTimeout = 30000,
    this.receiveTimeout = 30000,
    this.idleTimeout = 30000,
    this.returnOriginData = false,
    this.cancelToken,
    this.interceptor,
    this.headers,
    this.extra
  });

  /// 不传任何参数的空版本
  static get normal => HttpOptions();

  /// 合并
  merge({ 
    dynamic data, 
    Map<String, dynamic> query, 
    String method, 
    HttpContentType contentType, 
    ResponseType responseType, 
    String apiVersion, 
    int connectTimeout, 
    int receiveTimeout,
    int idleTimeout,
    CancelToken cancelToken, 
    Map<String, dynamic> headers, 
    bool returnOriginData, 
    InterceptorsWrapper interceptor, 
    Map<String, dynamic> extra
  }) {
    return HttpOptions(
      data: data ?? this.data,
      query: query ?? this.query,
      method: method ?? this.method,
      contentType: contentType ?? this.contentType,
      responseType: responseType ?? this.responseType,
      apiVersion: apiVersion ?? this.apiVersion,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      idleTimeout: idleTimeout ?? this.idleTimeout,
      cancelToken: cancelToken ?? this.cancelToken,
      interceptor: interceptor ?? this.interceptor,
      returnOriginData: returnOriginData ?? this.returnOriginData,
      headers: {
        ...headers ?? {},
        ...this.headers ?? {}
      },
      extra: {
        ...extra ?? {},
        ...this.extra ?? {}
      },
    );
  }

  /// 请求参数
  final dynamic data;
  /// url参数
  final Map<String, dynamic> query;
  /// 请求类型
  final String method;
  /// 请求内容类型
  final HttpContentType contentType;
  /// 返回值类型
  final ResponseType responseType;
  /// 后端API版本号
  final String apiVersion;
  /// 最大请求时间(ms)
  final int connectTimeout;
  /// 最大响应时间(ms)
  final int receiveTimeout;
  /// 最大闲置时间(ms)（仅用于HTTP2.0）
  final int idleTimeout;
  /// 头部参数
  final Map<String, dynamic> headers;
  /// 取消请求的Token
  final CancelToken cancelToken;
  /// 临时拦截器
  final InterceptorsWrapper interceptor;
  /// 用户自定义数据
  final Map<String, dynamic> extra;
  /// 返回原始数据
  final bool returnOriginData;
}

/// HTTP请求工具库，基于 `Dio` 封装
class HttpUtil {

  /// 预定义拦截器
  static List<InterceptorsWrapper> _interceptors = [];

  /// 获取Http内容类型枚举的字符串
  static String _getContentType(HttpContentType type) {
    switch(type) {
      case HttpContentType.json: return 'application/json;charset=UTF-8';
      case HttpContentType.form: return 'application/x-www-form-urlencoded';
      case HttpContentType.formData: return 'multipart/form-data';
      case HttpContentType.octetStream: return 'application/octet-stream';
      default: return '';
    }
  }

  /// 添加拦截器
  static addInterceptor(InterceptorsWrapper interceptor) {
    _interceptors.add(interceptor);
  }

  /// 移除拦截器
  static removeInterceptor(interceptor) {
    _interceptors.removeAt(_interceptors.indexOf(interceptor));
  }

  /// 清空所有拦截器
  static clearInterceptor(interceptor) {
    _interceptors = [];
  }

  /// get请求
  static Future<T> get<T>(String url, [Map<String, dynamic> query, HttpOptions options]) {
    return request<T>(url, (options ?? HttpOptions()).merge(
      method: 'GET',
      query: Map.fromEntries((query ?? {}).entries.where((item) => item.value != null))
    ));
  }

  /// post请求
  static Future<T> post<T>(String url, [dynamic data, HttpOptions options]) {
    return request<T>(url, (options ?? HttpOptions()).merge(
      method: 'POST',
      data: data
    ));
  }

  /// post表单提交
  static Future<T> formPost<T>(String url, [Map<String, dynamic> data = const {}, HttpOptions options]) {
    return request<T>(url, (options ?? HttpOptions()).merge(
      method: 'POST',
      contentType: HttpContentType.form,
      data: FormData.fromMap(data)
    ));
  }

  /// delete请求
  static Future<T> delete<T>(String url, [dynamic data, HttpOptions options]) async {
    return request<T>(url, (options ?? HttpOptions()).merge(
      method: 'DELETE',
      data: data
    ));
  }

  /// put请求
  static Future<T> put<T>(String url, [dynamic data, HttpOptions options]) {
    return request<T>(url, (options ?? HttpOptions()).merge(
      method: 'PUT',
      data: data
    ));
  }

  /// download请求
  static Future<T> download<T>(String url, [HttpOptions options]) {
    return request<T>(url, (options ?? HttpOptions()).merge(
      method: 'GET',
      responseType: ResponseType.bytes
    ));
  }

  /// post上传文件请求
  /// 
  /// 请求示例：
  /// ```
  /// HttpUtil.upload(url, {
  ///   "files": [
  ///     MultipartFile.fromFileSync("./example/upload1.txt", filename: "upload1.txt"),
  ///     MultipartFile.fromFileSync("./example/upload2.txt", filename: "upload2.txt")
  ///   ]
  /// });
  /// ```
  static Future<T> upload<T>(String url, [Map<String, dynamic> query, Map<String, dynamic> data, HttpOptions options]) {
    return request<T>(url, (options ?? HttpOptions()).merge(
      method: 'POST',
      query: query,
      contentType: HttpContentType.formData,
      data: FormData.fromMap(data)
    ));
  }

  /// 下载文件（暂未使用）
  @deprecated
  static Future<ResponseBody> saveFile(String url, [HttpOptions options]) async {
    ResponseBody body = await request<ResponseBody>(url, (options ?? HttpOptions()).merge(
      method: 'GET',
      contentType: HttpContentType.octetStream, 
      responseType: ResponseType.stream
    ));
    return body;
  }

  /// 从Response中获取Dio实例
  static Dio getDioForResponse(Response response) {
    return response?.extra['dio'];
  }

  /// 基础请求
  static Future<T> request<T>(String url, HttpOptions options) async {
    Response response = Response();
    Dio dio;

    try {
      // #d2a8ff
      print('[36;5;12m[${options.method}]${url}[0m');
      print('[36;5;12mParams: ${options.query ?? options.data}[0m');

      dio = Dio(
        BaseOptions(
          baseUrl: url.startsWith('http') ? null : _baseUrl,
          connectTimeout: options.connectTimeout,
          receiveTimeout: options.receiveTimeout,
          extra: {
            'dio': dio,
            ...options.extra
          }
        )
      );
      // HTTP2.0配置
      dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: options.idleTimeout,
          /// 忽略错误的证书
          onClientCreate: (_, clientSetting) => clientSetting.onBadCertificate = (_) => true,
        ),
      );
      // 抓包配置
      // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      //   client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      //     return Platform.isAndroid;
      //   };
      //   client.findProxy = (uri) {
      //     return "PROXY 192.168.3.4:8888";
      //   };
      // };

      // 添加预定义拦截器
      dio.interceptors.addAll(_interceptors);
      if (options.interceptor != null) dio.interceptors.add(options.interceptor);

      /// 头部校验token
      String _headerToken;
      /// 身份校验jwt串
      String _authorization = Cache.get('authorization');
      String time;

      if (_authorization == null || _authorization.isEmpty) {
        time = DateTime.now().millisecondsSinceEpoch.toString();
      }

      // url上如果有参数则视为url传参，否则从query或data中取
      if (url.indexOf('?') >= 0) {
        List<String> queryData = url.split('?')[1].split('&');
        queryData.sort();
        _headerToken = _apiKey + time.toString() + jsonEncode(queryData.join('')).replaceAll('\'', '').replaceAll('=', '');
      } else if (options.query != null) {
        List<String> queryData = options.query.keys.map((e) => e + (options.query[e] ?? '').toString()).toList();
        queryData.sort();
        _headerToken = _apiKey + time.toString() + jsonEncode(queryData.join('')).replaceAll('\'', '');
      } else {
        _headerToken = _apiKey + time.toString();
        if (options.data is Map) {
          _headerToken += jsonEncode(options.data);
        } else if (options.data is List) {
          _headerToken += options.data.toString();
        } else if (options.data is FormData) {
          _headerToken += (options.data as FormData).toString();
        } else {
          _headerToken += jsonEncode(options.data.toJson());
        }
      }

      dio.options.headers[HttpHeaders.acceptHeader] = _getContentType(options.contentType);
      response = await dio.request(url,
        queryParameters: options.query,
        data: options.data,
        cancelToken: options.cancelToken,
        options: Options(
          method: options.method,
          // contentType: _getContentType(options.contentType),
          responseType: options.responseType,
          headers: { 
            'Authorization': _authorization == null ? '' : 'Bearer ' + _authorization,
            'apiversion': options.apiVersion,
            'token': generateMd5(_headerToken),
            'time': time,
            ...options.headers
          },
          extra: {
            'dio': dio,
            ...options.extra
          }
        )
      );

      // print('响应数据：' + response.toString());
      // if (response.data.toString() == '') {
      //   throw DioError(
      //     type: DioErrorType.DEFAULT,
      //     error: '无数据返回'
      //   );
      // }
    } on DioError catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    } catch (e) {
      Log.error('未知错误: $e');
      rethrow;
    }

    dio.close();
    return response.data ?? response;
  }
}

/// 请求错误类
class HttpError {

  /// 错误code
  int code;
  /// 错误信息
  String message;
  /// 错误源
  DioError error;

  HttpError({this.error, this.code, this.message});

  /// 错误信息
  HttpError createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL: return HttpError(error: error, code: -1, message: 'error.http.cancel'.tr);
      case DioErrorType.DEFAULT: return HttpError(error: error, code: -1, message: 'error.http.default'.tr);
      case DioErrorType.CONNECT_TIMEOUT: return HttpError(error: error, code: -1, message: '网络开小差了啦');
      case DioErrorType.SEND_TIMEOUT: return HttpError(error: error, code: -1, message: '网络开小差了啦');
      case DioErrorType.RECEIVE_TIMEOUT: return HttpError(error: error, code: -1, message: '网络开小差了啦');
      case DioErrorType.RESPONSE:
        try {
          int errCode = error.response.statusCode;
          String errMsg = error?.response?.data['errMsg'] ?? '';

          if (errMsg.isNotEmpty) {
            return HttpError(error: error, code: errCode, message: errMsg);
          }
          switch (errCode) {
            case 400: return HttpError(error: error, code: errCode, message: '请求语法错误');
            case 401: return HttpError(error: error, code: errCode, message: '登录过期错误');
            case 403: return HttpError(error: error, code: errCode, message: '服务器拒绝执行');
            case 404: return HttpError(error: error, code: errCode, message: '无法连接服务器');
            case 405: return HttpError(error: error, code: errCode, message: '请求方法被禁止');
            case 500: return HttpError(error: error, code: errCode, message: '服务器内部错误');
            case 502: return HttpError(error: error, code: errCode, message: '无效的请求');
            case 503: return HttpError(error: error, code: errCode, message: '服务器挂了');
            case 505: return HttpError(error: error, code: errCode, message: '不支持HTTP协议请求');
            default: return HttpError(error: error, code: errCode, message: '未知错误');
          }
        } on Exception catch (_) {
          return HttpError(error: error, code: -1, message: '未知错误');
        }
        break;
      default: return HttpError(error: error, code: -1, message: error.message);
    }
  }
}