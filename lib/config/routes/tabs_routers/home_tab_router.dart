import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/page/home/home_binding.dart';
import 'package:haku_app/page/home/home_page.dart';
import 'package:haku_app/page/my/my_home_binding.dart';
import 'package:haku_app/page/my/my_home_page.dart';

import '../routers.dart';

class HomeTabRouter extends StatelessWidget {
  static const navigatorIndex = 1000;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(navigatorIndex),
      initialRoute: '/',
      onGenerateRoute: onGenerateRouter,
    );
  }

  static Route onGenerateRouter(RouteSettings settings) {
    if (settings.name == '/') {
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: HomeBinding()
      );
    }
    
    if (settings.name == Routes.my) {
      return GetPageRoute(
        settings: settings,
        page: () => MyHomePage(),
        binding: MyHomeBinding()
      );
    }

    throw Exception('找不到对应的页面');
  }
}
