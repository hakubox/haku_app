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
  
  /// 改变值事件
  void Function(dynamic val) change(dynamic data, [dynamic setValue]) => (dynamic val) {
    var _val = val;
    if (setValue != null) {
      _val = setValue;
    }
    if (data.runtimeType == RxString) {
      (data as RxString).value = _val.toString();
    } else if (data.runtimeType == RxBool) {
      (data as RxBool).value = _val;
    } else if (data.runtimeType == RxInt) {
      (data as RxInt).value = _val.runtimeType == int ? _val : int.tryParse(_val);
    } else if (data.runtimeType == RxDouble) {
      (data as RxDouble).value = _val.runtimeType == double ? _val : double.tryParse(_val);
    } else if (data.runtimeType == RxList) {
      (data as RxList).assignAll(_val);
    } else {
      throw Exception('data参数类型为${data.runtimeType.toString()}，尚未处理。');
    }
  };

  /// 改变值事件
  void Function() clear(dynamic data, [dynamic defaultValue]) => () {
    if (data.runtimeType == RxString) {
      (data as RxString).value = defaultValue ?? '';
    } else if (data.runtimeType == RxBool) {
      (data as RxBool).value = defaultValue ?? false;
    } else if (data.runtimeType == RxInt) {
      (data as RxInt).value = defaultValue ?? 0;
    } else if (data.runtimeType == RxDouble) {
      (data as RxDouble).value = defaultValue ?? 0.0;
    } else if (data.runtimeType == RxList) {
      (data as RxList).assignAll(defaultValue ?? []);
    }
  };
}