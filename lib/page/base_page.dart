import 'package:flutter/material.dart';
import 'package:haku_app/config/routes/tabs_routers/home_tab_router.dart';
import 'package:haku_app/config/routes/tabs_routers/list_tab_router.dart';
import 'package:haku_app/config/routes/tabs_routers/profile_tab_router.dart';
import 'package:haku_app/packages/icons/fryo_icons.dart';

const tabLinkStyle = TextStyle(fontWeight: FontWeight.w500);

class BasePage extends StatefulWidget {

  /// 页面标题
  final String pageTitle;

  BasePage({Key key, this.pageTitle}) : super(key: key);
  
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final pageViewController = PageController();

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(context) => Scaffold(
    body: PageView(
      controller: pageViewController,
      children: <Widget>[
        HomeTabRouter(),
        ListTabRouter(),
        ProfileTabRouter(),
      ],
    ),
    // floatingActionButton: Obx(() => FloatingActionButton(
    //   onPressed: () => Get.toNamed(Routes.cart),
    //   child: Icon(Fryo.cart),
    // )),
    bottomNavigationBar: AnimatedBuilder(
      animation: pageViewController,
      builder: (_, __) {
        return BottomNavigationBar(
          currentIndex: pageViewController?.page?.round() ?? 0,
          onTap: (page) {
            pageViewController.jumpToPage(page);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Fryo.home),
              title: Text('主页', style: tabLinkStyle)
            ),
            BottomNavigationBarItem(
              icon: Icon(Fryo.list),
              title: Text('列表', style: tabLinkStyle),
            ),
            BottomNavigationBarItem(
              icon: Icon(Fryo.user_1),
              title: Text('我的', style: tabLinkStyle),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green[600],
        );
      },
    )
  );
}