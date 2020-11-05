import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'dart:async';
import 'dart:convert';
import 'cache.dart';

/// API Key
const String _apiKey = 'gPmgRr9Dp3wzubTaGIgmMSpfNiKqkIAA0C8gkaBSN0ca3GWxk3W6682KuXRpxnDq';
/// 默认API版本
const String __apiVersion = '1.0.0';
/// 服务器地址
const String _baseUrl = 'http://AAAAAAAAAAAA:7001/api/';

/// http请求参数
class HttpOptions {
  /// http参数默认构造器
  const HttpOptions({
    this.data,
    this.query,
    this.method = 'GET',
    this.contentType = 'application/json;charset=UTF-8',
    this.responseType = ResponseType.json,
    this.apiVersion = __apiVersion,
    this.connectTimeout = 10000,
    this.receiveTimeout = 10000,
    this.idleTimeout = 10000,
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
    String contentType, 
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
      data: this.data ?? data,
      query: this.query ?? query,
      method: this.method ?? method,
      contentType: this.contentType ?? contentType,
      responseType: this.responseType ?? responseType,
      apiVersion: this.apiVersion ?? apiVersion,
      connectTimeout: this.connectTimeout ?? connectTimeout,
      receiveTimeout: this.receiveTimeout ?? receiveTimeout,
      idleTimeout: this.idleTimeout ?? idleTimeout,
      cancelToken: this.cancelToken ?? cancelToken,
      interceptor: this.interceptor ?? interceptor,
      returnOriginData: this.returnOriginData ?? returnOriginData,
      headers: {
        ...headers,
        ...this.headers
      },
      extra: {
        ...extra,
        ...this.extra
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
  final String contentType;
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
  static Future<Object> get(String url, [Map<String, dynamic> query, HttpOptions options]) {
    return request<dynamic>(url, options.merge(
      method: 'GET',
      query: query.map((key, value) => MapEntry(key, value.toString()))
    ));
  }

  /// post请求
  static Future<dynamic> post(String url, [dynamic data, HttpOptions options]) {
    return request<dynamic>(url, options.merge(
      method: 'POST',
      data: data
    ));
  }

  /// post表单提交
  static Future<dynamic> formPost(String url, [Map<String, dynamic> data, HttpOptions options]) {
    return request<dynamic>(url, options.merge(
      method: 'POST',
      contentType: Headers.formUrlEncodedContentType,
      data: FormData.fromMap(data)
    ));
  }

  /// delete请求
  static Future<dynamic> delete(String url, [dynamic data, HttpOptions options]) {
    return request<dynamic>(url, options.merge(
      method: 'DELETE',
      data: data
    ));
  }

  /// put请求
  static Future<dynamic> put(String url, [dynamic data, HttpOptions options]) {
    return request<dynamic>(url, options.merge(
      method: 'PUT',
      data: data
    ));
  }

  /// download请求
  static Future<dynamic> download(String url, [HttpOptions options]) {
    return request<dynamic>(url, options.merge(
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
  static Future<dynamic> upload(String url, [Map<String, dynamic> data, HttpOptions options]) {
    return request<dynamic>(url, options.merge(
      method: 'POST',
      contentType: 'multipart/form-data',
      data: FormData.fromMap(data)
    ));
  }

  /// 下载文件（暂未使用）
  // static Future<ResponseBody> saveFile(String url, [HttpOptions options]) async {
  //   ResponseBody body = await request<ResponseBody>(url, options.merge(
  //     method: 'GET',
  //     contentType: 'application/octet-stream', 
  //     responseType: ResponseType.stream
  //   ));
  //   return body;
  // }

  /// 从Response中获取Dio实例
  static Dio getDioForResponse(Response response) {
    return response?.extra['dio'];
  }

  /// 基础请求
  static Future<T> request<T>(String url, HttpOptions options) async {
    Response response = Response();
    Dio dio;

    try {
      print('___HTTP Request___');
      print('Url: [' + options.method + ']' + url);
      print('Params: ' + (options.query ?? options.data).toString());

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

      // 添加预定义拦截器
      dio.interceptors.addAll(_interceptors);
      if (options.interceptor != null) dio.interceptors.add(options.interceptor);

      // 头部校验token
      String _headerToken;
      // 身份校验jwt串
      String _authorization = Cache.get('authorization');
      int time;

      if (_authorization.isEmpty) {
        time = DateTime.now().millisecondsSinceEpoch;
      }

      // url上如果有参数则视为url传参，否则从query或data中取
      if (url.indexOf('?') >= 0) {
        List<String> queryData = url.split('?')[1].split('&');
        queryData.sort();
        _headerToken = _apiKey + time.toString() + jsonEncode(queryData.join('')).replaceAll('\'', '').replaceAll('=', '');
      } else if (options.query != null) {
        List<String> queryData = options.query.keys.map((e) => e + (options.query[e] ?? '').toString());
        queryData.sort();
        _headerToken = _apiKey + time.toString() + jsonEncode(queryData.join('')).replaceAll('\'', '');
      } else {
        _headerToken = _apiKey + time.toString() + jsonEncode(options.data);
      }

      response = await dio.request(url,
        queryParameters: options.query,
        data: options.data,
        cancelToken: options.cancelToken,
        options: Options(
          method: options.method,
          contentType: options.contentType,
          responseType: options.responseType,
          headers: { 
            'Authorization': 'Bearer ' + _authorization,
            'apiversion': options.apiVersion,
            'token': _headerToken,
            'time': time,
            ...options.headers
          },
          extra: {
            'dio': dio,
            ...options.extra
          }
        )
      );

      print('响应数据：' + response.toString());
    } on DioError catch (e) {
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
      case DioErrorType.CANCEL: return HttpError(error: error, code: -1, message: '请求取消');
      case DioErrorType.DEFAULT: return HttpError(error: error, code: -1, message: '请检查你的网络或者服务器地址以及服务器设备是否正常运行');
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