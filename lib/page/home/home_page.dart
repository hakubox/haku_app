import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/packages/icons/fryo_icons.dart';

import 'home_controller.dart';

/// 主页面
class HomePage extends GetView<HomeController> {

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      title: Obx(() => Text('home.title'.tr + '当前值：${controller.isSelected.value}')),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              child: Text('居中弹窗'),
              onPressed: () {
                Get.dialog(showDialog());
              },
            ),
            MaterialButton(
              child: Text('底部弹窗'),
              onPressed: () {
                Get.bottomSheet(showBottomDialog());
              },
            )
          ],
        ),
      ),
    ),
  );

  Widget showDialog() {
    return AlertDialog(
      actions: [
        FlatButton(
          child: Text("确定"),
          onPressed: () => Get.back()
        )
      ],
      content: Container(
        child: Obx(() => Wrap(
          children: [
            Switch(
              value: controller.isSelected.value,
              onChanged: (val) {
                controller.isSelected.value = val;
              }
            ),
            Text('当前值：${controller.isSelected.value}')
          ],
        ),
      )),
    );
  }

  Widget showBottomDialog() {
    return Container(
      color: Colors.white,
      child: Obx(() => Column(
        children: [
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("设置"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("主页"),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text("信息"),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Switch(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: controller.isSelected.value,
              onChanged: (val) {
                controller.isSelected.value = !controller.isSelected.value;
              }
            ),
            title: Text(controller.isSelected.value.toString()),
            onTap: () {
              controller.isSelected.value = !controller.isSelected.value;
            },
          ),
        ],
      )),
    );
  }
}