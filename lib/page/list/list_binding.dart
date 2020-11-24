import 'package:get/get.dart';
import 'list_controller.dart';

class ListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListController>(
      () => ListController(),
      fenix: true
    );
  }
}
