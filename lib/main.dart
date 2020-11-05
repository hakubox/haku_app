import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/root_widget.dart';
import 'package:haku_app/config/page_routers.dart';
import 'package:haku_app/theme/theme.dart';
import 'package:haku_app/utils/global.dart';
import 'package:oktoast/oktoast.dart';
import 'locales/locales.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 全局配置初始化
  await Global.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: currentTheme.primaryColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        // theme: currentTheme.getTheme(),
        theme: ThemeData.light(),
        darkTheme: AppTheme.dark.getTheme(),
        translationsKeys: AppTranslation.translations,
        // 默认路由
        initialRoute: '/',
        // 404路由
        // unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
        // 路由配置
        getPages: PageRouters.paths,
        // 路由跳转回调函数
        routingCallback: PageRouters.routerCallback,
        // 多语言配置
        locale: ui.window.locale,
        // fallbackLocale: Locale('en', 'US'),
      )
    );
  }
}