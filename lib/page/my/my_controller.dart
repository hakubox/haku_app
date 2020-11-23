import 'package:get/get.dart';
import 'package:haku_app/model/user_model.dart';
import 'package:haku_app/utils/cache.dart';
import 'package:haku_app/utils/controller/page_controller.dart';

/// 登录控制器
class MyController extends GetxController with PageController {

  /// 初始化函数
  @override
  onInit() {
    super.onInit();
    Cache.add('user_info', UserModel.toJson(UserModel(
      age: 18,
      name: '张三',
      id: 'a123'
    )));
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