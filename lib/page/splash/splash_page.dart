import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/component/img.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {

  @override
  Widget build(context) => Scaffold(
    backgroundColor: Colors.white,
    body: InkWell(
      child: Container(
        child: Center(
          child: Img('assets/img/no-image.jpg'),
        ),
      ),
    )
  );
}