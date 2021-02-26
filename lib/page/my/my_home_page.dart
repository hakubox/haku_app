import 'package:haku_app/component/index.dart';
import 'package:haku_app/theme/theme.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/page/my/my_home_controller.dart';
import 'package:haku_app/utils/global.dart';
import 'package:line_icons/line_icons.dart';

/// 我的页面
class MyHomePage extends GetView<MyHomeController> {

  /// 创建快速菜单
  Widget getQuickMenu(String label, IconData icon, Function onTap) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 0,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: currentTheme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(6))
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(label),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  /// 菜单
  getMenu(String title, IconData icon, Function onTap) {
    return InkWell(
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: 20,
          right: 10
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFDDDDDD),
              width: 0.5
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 6,
              children: [
                Icon(icon, size: 24),
                Text(title, style: TextStyle(
                    fontSize: 16
                  ),
                )
              ],
            ),
            Icon(
              LineIcons.angle_right,
              color: Color(0xFFCCCCCC)
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0
      ),
      backgroundColor: Color(0xFFF0F1F6),
      body: SafeArea(
        child: RefreshIndicator(
          displacement: 40.0,
          notificationPredicate: defaultScrollNotificationPredicate,
          onRefresh: controller.onRefresh,
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                color: currentTheme.primaryColor,
                padding: EdgeInsets.only(left: 15, top: 20, bottom: 6),
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: InkWell(
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Img('temp/head.png',
                                    width: 60, 
                                    height: 60, 
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.circular(30),
                                    margin: EdgeInsets.only(right: 14)
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('管理员', style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white
                                      )),
                                      Text(Global.userInfo.name, style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        height: 1.6,
                                        color: Colors.white
                                      ))
                                    ],
                                  )
                                )
                              ],
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Icon(LineIcons.bell, color: Colors.white, size: 30),
                                ),
                                onTap: () {
                                },
                              ),
                            )
                            // Positioned(
                            //   right: -20,
                            //   bottom: -20,
                            //   child: Img('logo.png', width: 140, opacity: 0.4),
                            // )
                          ],
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 0
                        ),
                        child: ExpandableTheme(
                          data: ExpandableThemeData(
                            useInkWell: true,
                            iconColor: Colors.white,
                            iconRotationAngle: 3.1415926,
                            iconPadding: EdgeInsets.all(12.0),
                          ),
                          child: ExpandablePanel(
                            controller: controller.expandableController.value,
                            header: InkWell(
                              child: Container(
                                padding: EdgeInsets.only(left: 0, top: 12, bottom: 6),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 6,
                                  children: [
                                    Icon(LineIcons.volume_up, color: Colors.white),
                                    Text('展开项标题', 
                                      style: TextStyle(color: Colors.white)
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                
                              },
                            ),
                            // expanded: Text(''),
                            collapsed: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 5, bottom: 5),
                                        child: Wrap(
                                          spacing: 10,
                                          children: [
                                            Text('累积上传数', style: TextStyle(color: Colors.white),),
                                            Text('0个', style: TextStyle(color: Color(0xAAFFFFFF)),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 5, bottom: 5),
                                        child: Wrap(
                                          spacing: 10,
                                          children: [
                                            Text('累积下载数', style: TextStyle(color: Colors.white),),
                                            Text('0个', style: TextStyle(color: Color(0xAAFFFFFF)),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 5, bottom: 5),
                                        child: Wrap(
                                          spacing: 10,
                                          children: [
                                            Text('已完成工单', style: TextStyle(color: Colors.white),),
                                            Text('0个', style: TextStyle(color: Color(0xAAFFFFFF)),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 5, bottom: 5),
                                        child: Wrap(
                                          spacing: 10,
                                          children: [
                                            Text('未完成工单', style: TextStyle(color: Colors.white),),
                                            Text('0个', style: TextStyle(color: Color(0xAAFFFFFF)),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    width: Get.width,
                    height: 90,
                    color: currentTheme.primaryColor,
                  ),
                  Container(
                    width: Get.width,
                    height: 220
                  ),
                  Positioned(
                    top: 0,
                    width: Get.width,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  getQuickMenu('我的收藏', LineIcons.star_o, () {
                                  }),
                                  getQuickMenu('我的素材', LineIcons.archive, () {
                                  }),
                                  Container(
                                    width: 55,
                                  )
                                  // getQuickMenu('我的发布', LineIcons.paper_plane, () {

                                  // }),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 20
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  getQuickMenu('我的待办', LineIcons.calendar, () {
                                  }),
                                  getQuickMenu('我的下载', LineIcons.download, () {
                                  }),
                                  getQuickMenu('我的工单', LineIcons.list_alt, () {
                                  }),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              getMenu('切换品牌', LineIcons.puzzle_piece, () {
              }),
              getMenu('联系客服', LineIcons.headphones, () {
              }),
              getMenu('证书页', LineIcons.registered, () {
              }),
              getMenu('设置', LineIcons.wrench, () {
              }),
              SizedBox( height: 15 ),
              InkWell(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    bottom: 15
                  ),
                  color: Colors.white,
                  child: Text('退出登录', style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                ),
                onTap: () {
                  Global.logout();
                  Get.offAllNamed(Routes.login);
                },
              )
            ],
          ),
          // child: Obx(() => MaterialButton(
          //     child: Text(myController.userInfo.value.name),
          //     onPressed: () {
          //       Get.toNamed(Routes.login);
          //     },
          //   ),
          // )
        ),
      ),
    );
  }
}