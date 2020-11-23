import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/packages/app_router/app_page.dart';
import 'package:haku_app/page/home/home_page.dart';
import 'package:haku_app/page/list/list_page.dart';
import 'package:haku_app/page/login/login_binding.dart';
import 'package:haku_app/page/login/login_page.dart';
import 'package:haku_app/page/base_page.dart';
import 'package:haku_app/page/my/my_page.dart';
import 'package:haku_app/page/splash/splash_binding.dart';
import 'package:haku_app/page/splash/splash_page.dart';
import '../../page/home/home_binding.dart';
import '../../page/list/list_binding.dart';
import '../../page/my/my_binding.dart';

/// 路由表
final List<AppPage> pages = [
  AppPage(name: Routes.splash, page: () => SplashPage(), binding: SplashBinding()),
  AppPage(name: Routes.init, page: () => HomePage(), binding: HomeBinding()),
  AppPage(name: Routes.base, page: () => BasePage()),
  AppPage(name: Routes.home, page: () => HomePage(), binding: HomeBinding()),
  AppPage(name: Routes.login, page: () => LoginPage(), binding: LoginBinding()),
  AppPage(name: Routes.list, page: () => ListPage(), binding: ListBinding()),
  AppPage(name: Routes.my, page: () => MyPage(), binding: MyBinding()),
  // GetPage(
  //   name: '/third',
  //   page: () => Third(),
  //   transition: Transition.zoom
  // ),
];