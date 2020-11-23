import 'package:get/get.dart';
import 'package:haku_app/page/my/my_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyController>(
      () => MyController(),
      fenix: true
    );
  }
}
