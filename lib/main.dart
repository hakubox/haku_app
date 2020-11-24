import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/root_widget.dart';
import 'package:haku_app/config/routes/pages.dart';
import 'package:haku_app/packages/app_lifecycle/app_lifecycle.dart';
import 'package:haku_app/packages/app_router/page_routers.dart';
import 'package:haku_app/theme/theme.dart';
import 'package:haku_app/utils/global.dart';
import 'package:oktoast/oktoast.dart';
import 'config/routes/routers.dart';
import 'locales/locales.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 全局配置初始化
  await Global.init();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: currentTheme.primaryColor,
  //   statusBarBrightness: Brightness.light,
  //   statusBarIconBrightness: Brightness.light,
  // ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
 
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => AppLifecycle.state = state;

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'Haku App',
        // theme: currentTheme.getTheme(),
        theme: ThemeData.light(),
        darkTheme: AppTheme.dark.getTheme(),
        translationsKeys: AppTranslation.translations,
        // 默认路由
        initialRoute: Routes.login,
        // 404路由
        // unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
        // 路由配置
        getPages: PageRouters.getPaths(pages),
        // 路由跳转回调函数
        routingCallback: PageRouters.routerCallback,
        // 多语言配置
        locale: ui.window.locale,
        fallbackLocale: Locale('en', 'US'),
      )
    );
  }
}