
import 'package:get/get.dart';
import 'package:haku_app/page/home_page.dart';
import 'package:haku_app/page/login_page.dart';

/// 路由枚举配置
abstract class Routes {
  /// 初始页面
  static const INIT = '/';
  /// 主页面
  static const HOME = '/home';
  /// 登录页
  static const LOGIN = '/login';
}

/// 页面路由
abstract class PageRouters {

  /// 路由表
  static final List<GetPage> paths = [
    GetPage(name: Routes.INIT, page: () => HomePage()),
    GetPage(name: Routes.HOME, page: () => HomePage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    // GetPage(
    //   name: '/third',
    //   page: () => Third(),
    //   transition: Transition.zoom
    // ),
  ];

  /// 路由跳转钩子
  static routerCallback(Routing routing) {
    if(routing.current == '/second') {
      // openAds();
    }
  }
}