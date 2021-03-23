import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/page/list/list_binding.dart';
import 'package:haku_app/page/my/my_home_binding.dart';
import 'package:haku_app/page/home/home_page.dart';
import 'package:haku_app/page/my/my_home_page.dart';

import '../routers.dart';

class ProfileTabRouter extends StatelessWidget {
  static const navigatorIndex = 3000;

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
        page: () => MyHomePage(),
        binding: MyHomeBinding()
      );
    }
    
    if (settings.name == Routes.my) {
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: ListBinding()
      );
    }

    throw Exception('找不到对应的页面');
  }
}
