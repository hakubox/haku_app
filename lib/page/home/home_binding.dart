import 'package:get/get.dart';
import 'package:haku_app/page/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true
    );
  }
}
