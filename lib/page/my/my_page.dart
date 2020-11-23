import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/packages/icons/fryo_icons.dart';
import 'package:haku_app/page/my/my_controller.dart';
import 'package:haku_app/utils/global.dart';

class MyPage extends GetView<MyController> {

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      title: Text('my.title'.tr),
      actions: [
        IconButton(
          icon: Icon(Fryo.home),
          onPressed: () {
            Get.offAllNamed(Routes.base);
          },
        )
      ]
    ),
    body: Container(
      child: Column(
        children: [
          Expanded(
            flex: 0,
            child: Row(
              children: [
                Text('用户名'),
                Text(Global.userInfo.username)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: MaterialButton(
                child: Text('退出登录'),
                onPressed: () {
                  Get.toNamed(Routes.login);
                },
              ),
            ),
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
  );
}