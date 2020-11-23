import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/component/textbox.dart';
import 'package:haku_app/packages/icons/fryo_icons.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Container(
        padding: EdgeInsets.only(
          top: 80, left: 40, right: 40, bottom: 40
        ),
        child: Obx(() => Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextBox(
                    labelText: 'login.username'.tr,
                    controller: controller.usernameController,
                    errorText: controller.usernameIsInvalid ? null : 'login.username_invaild'.tr,
                    prefixIcon: Icon(Fryo.user),
                    suffixIcon: controller.username.value.isNotEmpty ? IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.grey,
                      iconSize: 18.0,
                      onPressed: controller.clearUsername,
                    ) : SizedBox(),
                    onChanged: controller.changeUsername,
                    onSaved: controller.changeUsername,
                  ),
                  TextBox(
                    labelText: 'login.password'.tr,
                    controller: controller.passwordController,
                    errorText: controller.passwordIsInvalid ? null : 'login.password_invaild'.tr,
                    prefixIcon: Icon(Fryo.lock),
                    suffixIcon: controller.username.value.isNotEmpty ? IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.grey,
                      iconSize: 18.0,
                      onPressed: controller.clearPassword,
                    ) : SizedBox(),
                    onChanged: controller.changePassword,
                    onSaved: controller.changePassword,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text('login.login'.tr),
                onPressed: controller.login,
              ),
            ],
          )
        ),
      ),
    ),
  );
}