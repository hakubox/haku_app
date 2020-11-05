
import 'package:get/get.dart';
import 'package:haku_app/page/home/home_page.dart';
import 'package:haku_app/page/login/login_page.dart';

import 'routes.dart';

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