import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:haku_app/page/login/login_controller.dart';
import 'package:haku_app/component/index.dart';

class LoginPage extends StatelessWidget {

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Obx(() => Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextBox(
                      labelText: 'login.username'.tr,
                      // controller: loginController.usernameController,
                      errorText: loginController.usernameIsValid ? null : 'login.username_invaild'.tr,
                      prefixIcon: Icon(FeatherIcons.user),
                      suffixIcon: loginController.username.value.isNotEmpty ? IconButton(
                        icon: Icon(Icons.cancel),
                        color: Colors.grey,
                        iconSize: 18.0,
                        onPressed: loginController.clearUsername,
                      ) : SizedBox(),
                      onChanged: loginController.changeUsername,
                      onSaved: (value) {
                        loginController.username.value = value;
                      },
                    ),
                    TextBox(
                      labelText: 'login.password'.tr,
                      errorText: loginController.passwordIsValid ? null : 'login.password_invaild'.tr,
                      prefixIcon: Icon(FeatherIcons.lock),
                      suffixIcon: loginController.username.value.isNotEmpty ? IconButton(
                        icon: Icon(Icons.cancel),
                        color: Colors.grey,
                        iconSize: 18.0,
                        onPressed: loginController.clearPassword,
                      ) : SizedBox(),
                      onChanged: loginController.changePassword,
                      onSaved: (value) {
                        loginController.password.value = value;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  child: Text('login.login'.tr),
                  onPressed: loginController.login,
                ),
              ],
            )
          )),
        ),
        // Text("Go to Other"), onPressed: () => Get.to(Other())
      ),
      // body: Center(
      //   child: Container(
      //       height: 300,
      //       child: Obx(() => Form(
      //       child: Column(
      //         children: [
      //           Container(
      //             padding: EdgeInsets.all(50),
      //             child: Row(
      //               children: [
      //                 Container(
      //                   margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
      //                   height: 50,
      //                   child:  TextFormField(
      //                     obscureText: true,
      //                     keyboardType: TextInputType.text,
      //                     initialValue: loginController.username.value,
      //                     // controller: _passwrodController,
      //                     style: TextStyle(fontSize: 15, height: 1.3),
      //                     cursorWidth: 1.0,
      //                     // cursorColor: wxTextColor,
      //                     decoration: InputDecoration(
      //                       hintText: '请输入账号',
      //                       hintStyle: TextStyle(color: Colors.red, fontSize: 15, height: 1),
      //                       focusedBorder: OutlineInputBorder(
      //                         //选中时外边框颜色
      //                         borderRadius: BorderRadius.circular(4.0),
      //                         borderSide: BorderSide(
      //                           // color: primaryColor,
      //                           width: 1,
      //                         ),
      //                       ),
      //                       suffixIcon: Container(
      //                         width: 45,
      //                         child: Flex(
      //                           direction: Axis.horizontal,
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: <Widget>[
      //                             Visibility(
      //                               child: IconButton(
      //                                 icon: Icon(Icons.cancel),
      //                                 color: Colors.grey,
      //                                 iconSize: 18.0,
      //                                 onPressed: () {
      //                                   loginController.username.value = '';
      //                                 },
      //                               ),
      //                               visible: loginController.username.value.isNotEmpty,
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0), borderSide: BorderSide(color: currentTheme.borderColor, width: 1)),
      //                     ),
      //                     onChanged: (value) {
      //                     },
      //                   )
      //                 )
      //               ],
      //             ),
      //           ),
      //           Obx(() => Text("Clicks: ${loginController.username}")),
      //           MaterialButton(
      //             child: Text('登录'),
      //             onPressed: loginController.login,
      //           )
      //         ],
      //         ),
      //       ),
      //   ))
      //   // Text("Go to Other"), onPressed: () => Get.to(Other())
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens), 
        onPressed: () {
          loginController.clearUsername();
          loginController.update();
        }
      )
  );
}

class OtherPage extends StatelessWidget {
  final LoginController c = Get.find();

  @override
  Widget build(context) {
     // 访问更新后的计数变量
     return Scaffold(body: Center(child: Text("${c.username}")));
  }
}