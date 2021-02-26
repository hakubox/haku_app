import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:haku_app/component/index.dart';
import 'package:haku_app/utils/controller/base_controller.dart';

/// 我的页面控制器
class MyHomeController extends GetxController with BaseController {

  /// 展开收起控制器
  var expandableController = ExpandableController(
    initialExpanded: true
  ).obs;

  /// 获取数据
  Future<void> getData() {
    Toast.loading();
    return Future.wait<dynamic>([
    ]).then((d) {
    }).whenComplete(() {
      Future.delayed(Duration(milliseconds: 1000), Toast.hideAll);
    });
  }

  /// 下拉刷新
  Future<void> onRefresh() {
    return getData();
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
    getData();
  }

  /// 销毁后调用
  @override
  onClose() {
    super.onClose();
  }
}