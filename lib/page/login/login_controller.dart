import 'package:get/get.dart';
import 'package:haku_app/utils/console/console.dart';
import 'package:haku_app/utils/http-util.dart';

/// 登录控制器
class LoginController extends GetxController {

  /// 用户名
  final RxString username = ''.obs;
  /// 密码
  final RxString password = ''.obs;

  /// 清空用户名
  clearUsername() {
    this.username.value = '';
  }

  /// 登录
  login() {
    this.username.value = '已登录';
    // HttpUtil.post('user/login', {
    //   'username': username,
    //   'password': password
    // }).then((value) {

    // }).catchError((error) {

    // });
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