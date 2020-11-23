import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/packages/icons/fryo_icons.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      title: Text('home.title'.tr),
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
          child: Text('主页'),
          onPressed: () {
          },
        ),
      ),
    ),
  );
}