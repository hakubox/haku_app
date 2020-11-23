import 'dart:ui';

import 'package:dio/dio.dart';
// import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:haku_app/model/user_model.dart';
import 'package:haku_app/packages/app_lifecycle/app_lifecycle.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:haku_app/packages/network_state/network_state.dart';
import 'package:haku_app/utils/http-util.dart';
import 'package:haku_app/utils/sys-permission.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert' as convert;
import 'cache.dart';

abstract class Global {
  /// 网络缓存对象
  // static NetCache netCache = NetCache();

  /// 个人信息
  static UserModel userInfo;

  /// App状态
  static AppLifecycleState lifecycleState;

  /// 是否为生产环境
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// 登录并赋权限
  static void login(UserModel user) {
    userInfo = user;
    Cache.add('user_info', convert.jsonEncode(UserModel.toJson(user)));
  }

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {

    // 获取系统权限
    SysPermission.requestAll([
      Permission.storage,
      Permission.phone,
      Permission.photos,
      Permission.camera
    ]);

    // 初始化缓存
    await Cache.init();

    if (Cache.contains('user_info')) {
      var _user = convert.jsonDecode(Cache.get('user_info'));
      userInfo = UserModel.fromJson(_user);
    }

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
      onRequest: (RequestOptions options) async {
        return options;
      }, 
      // 响应之前
      onResponse: (Response response) async {
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

    // 添加fluwx初始化
    // registerWxApi(appId: "wxd930ea5d5a228f5f", universalLink: "https://your.univerallink.com/link/");
  }

}