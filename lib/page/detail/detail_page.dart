import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/model/event_model.dart';
import 'package:haku_app/packages/icons/fryo_icons.dart';

import 'detail_controller.dart';

/// 详情页面
class DetailPage extends GetView<DetailController> {
  final EventModel model;

  DetailPage({@required this.model}) : assert(model != null);

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      title: Text(model.clubName),
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
          child: Text(model.clubName),
          onPressed: () {
          },
        ),
      ),
    ),
  );
}