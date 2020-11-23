import 'package:get/get.dart';
import '../app_state.dart';

/// 分页页面控制器
class ListPageController {
  /// 当前页数
  var pageNum = 1.obs;
  /// 当前页大小
  var pageSize = 10.obs;
  /// 数据总条数
  var total = 0.obs;
  /// App状态
  var appState = Rx<AppState>();
}