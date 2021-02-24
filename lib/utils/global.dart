import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:haku_app/api/user_api.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/model/user_model.dart';
import 'package:haku_app/packages/app_lifecycle/app_lifecycle.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:haku_app/packages/network_state/network_state.dart';
import 'package:haku_app/utils/http-util.dart';
import 'package:haku_app/utils/sys-permission.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert' as convert;
import 'address_data.dart';
import 'cache.dart';

/// 消息类型
class MessageType {
  /// 工单消息
  static String workorder = 'message_workorder';
  /// 加盟商入驻消息
  static String franchiseeJoin = 'message_franchiseejoin';
}

abstract class Global {
  /// 网络缓存对象
  // static NetCache netCache = NetCache();

  /// App状态
  static AppLifecycleState lifecycleState;

  /// 省市区Ids
  static Map<String, int> addressIds;

  /// 省市区地图
  static List<Map<String, dynamic>> addressMap;

  /// 是否为生产环境
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// 默认文件夹
  static Directory defaultDir;

  /// 个人信息
  static UserModel get userInfo {
    if (Cache.contains('user_info')) {
      return UserModel.fromJson(convert.jsonDecode(Cache.get('user_info')) as Map);
    }
    return UserModel(
      name: ''
    );
  }

  /// 是否为品牌商
  static bool get isBrandowner {
    if (Cache.contains('user_info')) {
      Map userInfo = convert.jsonDecode(Cache.get('user_info')) as Map;
      return userInfo['role'] == 'brandowner';
    }
    return null;
  }

  /// 登录并赋权限
  static Future<UserModel> getUser() async {
    var _userInfo = await UserApi.getAll();
    Cache.add<String>('user_info', convert.jsonEncode(UserModel.toJson(_userInfo)));
    return _userInfo;
  }

  /// 登录
  static Future<bool> login(String token) async {
    try {
      setToken(token);
      await getUser();
      return true;
    } catch(err) {
      Log.error(err);
      return false;
    }
  }

  /// 注销账号
  static void logout() {
    Cache.remove('user_info');
    Cache.remove('authorization');
    Get.offAllNamed(Routes.login);
  }

  /// 判断是否登录
  static isLogin() {
    // 包含token
    if (Cache.contains('authorization')) {
      String token = Cache.get('authorization');
      if (token != null && token.isNotEmpty) {
        // 判断token是否已过期
        if (token == '') {
          return false;
        }
        return true;
      }
    }
    return false;
  }
  
  /// 全局异常
  static void onError(FlutterErrorDetails details, [StackTrace stackTrace]) {
    String msg = '';
    if (details?.exception != null) {
      if (details.exception is String) {
        msg = details.exception;
      } else if (details.exception is TypeError) {
        msg = details.exception.toString();
      } else {
        try {
          msg = details?.exception?.message;
        } catch (e) {
          msg = details.exception.toString();
        }
      }
    } else {
      msg = details?.summary?.value;
    }
    StackTrace stack = stackTrace ?? details.stack ?? details?.exception?.stackTrace;
    Log.error('[系统错误]${msg}', details.exception, stack);
  }

  /// 设置Token
  static Future<bool> setToken(String val) {
    return Cache.add<String>('authorization', val);
  }

  static Map autoCycleData = {};

  /// 自动循环任务
  static autoCycleTask() {
    Future.delayed(Duration(minutes: 1), () {
    });
  }

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {

    defaultDir = await getTemporaryDirectory();

    // 固定垂直向上屏幕
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // 绑定全局异常
    FlutterError.onError = Global.onError;

    // 获取系统权限
    SysPermission.requestAll([
      Permission.storage,
      Permission.phone,
      Permission.photos,
      Permission.camera,
    ]);

    // 初始化缓存
    await Cache.init();

    Future.delayed(Duration(seconds: 1), () {
      if (!isLogin()) {
        Get.toNamed(Routes.login);
      }
    });

    // 初始化Get库全局配置
    Get.config(
      enableLog: true,
      defaultPopGesture: true,
      defaultTransition: Transition.cupertino
    );

    // App生命周期监听
    AppLifecycle.listen((AppLifecycleState state) { });

    // 网络状态监听
    NetworkState.listen((event) { });

    // _prefs = await SharedPreferences.getInstance();
    // var _profile = _prefs.getString("profile");
    // if (_profile != null) {
    //   try {
    //     profile = ProfileModel.fromJson(jsonDecode(_profile));
    //   } catch (e) {
    //     Log.error(e);
    //   }
    // }

    // 如果没有缓存策略，设置默认缓存策略
    // profile.cache = profile.cache ?? CacheConfig()
    //   ..enable = true
    //   ..maxAge = 3600
    //   ..maxCount = 100;

    // 添加预定义拦截器
    HttpUtil.addInterceptor(InterceptorsWrapper(
      // 请求之前
      onRequest: (options) async {
        return options;
      }, 
      // 响应之前
      onResponse: (response) async {
        // 判断如果有新token则替换原始值
        // Dio dio = HttpUtil.getDioForResponse(response);
        // if (dio != null) dio.lock();
        return response;
      },
      // 错误之前
      onError: (DioError e) async {
        HttpError en = HttpError().createErrorEntity(e);
        if (en.code == 401) {
          Log.error('401处理');
        } else if (en.code == 403) {
          Log.error('403处理');
        }
        Log.error('请求出错：' + en.message);
        return en;
      }
    ));

    addressMap = initAddressMap();
    addressIds = initAddressIds();

    autoCycleTask();

    // 添加fluwx初始化
    // registerWxApi(appId: "wxd930ea5d5a228f5f", universalLink: "https://your.univerallink.com/link/");
  }

}