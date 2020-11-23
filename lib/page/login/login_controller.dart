import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/model/user_model.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:haku_app/packages/network_state/network_state.dart';
import 'package:haku_app/utils/feature-permission.dart';
import 'package:haku_app/utils/global.dart';
import 'package:haku_app/utils/http-util.dart';

/// 登录控制器
class LoginController extends GetxController {

  /// 用户名
  final RxString username = ''.obs;
  /// 密码
  final RxString password = ''.obs;

  /// 用户名控制器
  final TextEditingController usernameController = TextEditingController();
  /// 密码控制器
  final TextEditingController passwordController = TextEditingController();

  bool get usernameIsInvalid => username.value.isEmpty || username.value.length < 3;

  bool get passwordIsInvalid => password.value.isEmpty || password.value.length < 6;

  bool get formLoginIsInvalid => usernameIsInvalid || passwordIsInvalid;

  clearUsername() => this.username.value = '';
  clearPassword() => this.password.value = '';

  changeUsername(String value) => username.value = value;
  changePassword(String value) => password.value = value;

  /// 登录
  login() async {
    
    if (formLoginIsInvalid) {
      Get.snackbar('提示', '账号或密码不符合格式！',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } else {
      Log.info('登录了');

      FeaturePermission.request('');


      // var userInfo = await HttpUtil.post('user/login', {
      //   'username': username,
      //   'password': password
      // });
      UserModel user = UserModel(
        id: '1',
        username: username.value,
        password: password.value
      );
      Global.login(user);
      clearUsername();
      clearPassword();
      Get.toNamed(Routes.base);
      Get.snackbar('提示', '已登录',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    }
  }

  /// 注册
  register() {
    HttpUtil.post('user/register', {
      'username': username,
      'password': password
    }).then((value) {

    }).catchError((error) {
      
    });
  }

  /// 初始化函数
  @override
  onInit() {
    super.onInit();
    NetworkState.listen((state) {
      switch(state) {
        case ConnectivityResult.mobile:
        break;
        case ConnectivityResult.wifi:
        break;
        case ConnectivityResult.none:
        break;
      }
    });
  }

  /// 显示后调用
  @override
  onReady() {
    super.onReady();
  }

  /// 销毁后调用
  @override
  onClose() {
    super.onClose();
  }
}