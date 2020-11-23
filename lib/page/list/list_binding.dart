import 'package:get/get.dart';
import 'package:haku_app/page/list/list_controller.dart';

class ListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListController>(
      () => ListController(),
      fenix: true
    );
  }
}
