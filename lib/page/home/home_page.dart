import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('home_title'.tr)),
      body: Container(
        child: GetX<HomeController>(
          init: HomeController(),
          builder: (_) {
            return Center(
              child: MaterialButton(
                child: Text(homeController.name.value),
                onPressed: () {
                  Get.toNamed(Routes.LOGIN);
                },
              ),
            );
          }
        ),
      ),
    );
  }
}