import 'package:flutter/material.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/custom_transition.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

/// App页面
class AppPage {
  /// 页面名称（非标题）
  String name;
  /// 页面权限
  String permission;
  GetPageBuilder page;
  /// 开启手势
  bool popGesture;
  /// 页面参数
  Map<String, String> parameter;
  /// 页面标题
  String title;
  /// 页面过渡动画
  Transition transition;
  /// 中间件
  List<GetMiddleware> middlewares;
  Curve curve;
  Alignment alignment;
  bool maintainState;
  bool opaque;
  Bindings binding;
  List<Bindings> bindings;
  CustomTransition customTransition;
  Duration transitionDuration;
  bool fullscreenDialog;
  RouteSettings settings;

  AppPage({
    @required this.name,
    @required this.page,
    this.title,
    this.settings,
    this.maintainState = true,
    this.curve = Curves.linear,
    this.alignment,
    this.parameter,
    this.opaque = true,
    this.transitionDuration,
    this.popGesture,
    this.binding,
    this.bindings,
    this.transition,
    this.customTransition,
    this.fullscreenDialog = false,
    this.middlewares,
  })  : assert(page != null),
        assert(name != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null);

  GetPage getPage() {
    return GetPage(
      title: title,
      name: name,
      page: page,
      binding: binding,
      bindings: bindings,
      settings: settings,
      parameter: parameter,
      transition: transition,
      fullscreenDialog: fullscreenDialog,
      middlewares: middlewares
    );
  }
}