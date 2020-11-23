import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/page/login/login_page.dart';
import 'package:haku_app/utils/feature-permission.dart';
import 'app_page.dart';

/// 页面路由
abstract class PageRouters {

  /// 校验是否已登录
  static GetPageBuilder _checkLogin(AppPage page) {
    // 如果未登录
    if (1 == 2) {
      // { 'error-type': 'not-login' }
      return () => LoginPage();
    }
    // 如果JWT超时
    if (1 == 2) {
      // { 'error-type': 'token-expire' }
      return () => LoginPage();
    }
    // 无权限
    if (!FeaturePermission.request(page.permission)) {
      // { 'error-type': 'no-permission', 'permission': page.permission }
      return () => LoginPage();
    }
    return () => page.page();
  }

  /// 获取所有路由
  static List<GetPage> getPaths(List<AppPage> paths) => paths.map((AppPage appPage) {
    Widget Function() _page;
    if ([Routes.login].contains(appPage.name)) {
      _page = _page;
    } else {
      _page = _checkLogin(appPage);
    }
    return appPage.getPage();
  }).toList();

  /// 路由跳转钩子
  static routerCallback(Routing routing) {
  }
}