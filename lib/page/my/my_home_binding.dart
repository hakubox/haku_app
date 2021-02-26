import 'package:get/get.dart';
import 'my_home_controller.dart';

class MyHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyHomeController>(
      () => MyHomeController(),
      fenix: true
    );
  }
}
