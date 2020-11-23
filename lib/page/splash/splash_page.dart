import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/packages/icons/fryo_icons.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      title: Text('闪屏页'),
      actions: [
        IconButton(
          icon: Icon(Fryo.user),
          onPressed: () {
            Get.toNamed(Routes.my);
          },
        )
      ]
    ),
    body: Container(
      child: Center(
        child: MaterialButton(
          child: Text('跳转到登录页'),
          onPressed: () {
            Get.toNamed(Routes.login);
          },
        ),
      ),
    ),
  );
}