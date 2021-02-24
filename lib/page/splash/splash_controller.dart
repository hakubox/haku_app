import 'package:get/get.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/utils/controller/base_controller.dart';

/// 登录控制器
class SplashController extends GetxController with BaseController {

  /// 初始化函数
  @override
  onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      print('页面跳转');
      Get.offNamed(Routes.login);
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