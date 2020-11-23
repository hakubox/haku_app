import 'package:get/get.dart';

/// 分页
class ListPageController {
  /// 当前页数
  var pageNum = 1.obs;
  /// 当前页大小
  var pageSize = 10.obs;
  /// 数据总条数
  var total = 0.obs;
}