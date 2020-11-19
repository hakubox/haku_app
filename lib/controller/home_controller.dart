import 'package:get/get.dart';
import 'package:haku_app/packages/log/log.dart';

/// 登录控制器
class HomeController extends GetxController {

  /// 名称
  var name = '123'.obs;

  /// 初始化函数
  @override
  onInit() {
    Log.warn('警告！！！！');
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