import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';
import 'package:get/get.dart';
import 'package:haku_app/api/event_api.dart';
import 'package:haku_app/model/event_model.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:haku_app/utils/app_state.dart';
import 'package:haku_app/utils/list_page_controller.dart';

/// 列表页控制器
class ListController extends GetxController with ListPageController {

  ListController();

  static ListController get to => Get.find();

  /// App状态
  final appState = Rx<AppState>();

  /// 活动列表
  var eventList = <EventModel>[].obs;

  /// 排序项
  var sortConfig = {
    'itemA': { 'sort': 'desc' },
    'itemB': { 'sort': '' },
    'itemC': { 'sort': '' }
  }.obs;

  /// 列表控制器
  FRefreshController refreshController = FRefreshController();

  /// 获取数据
  load([bool nextPage = false]) async {
    try {
      appState.value = AppState.LOADING;
      await getData(nextPage);
      appState.value = AppState.DONE;
    } on Exception catch (e) {
      Log.log(e.toString());
      Get.snackbar('警告', '获取数据错误！',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      appState.value = AppState.ERROR;
    }
  }

  /// 获取数据
  getData([bool nextPage = false]) async {
    if (nextPage) {
      eventList.value = [
        ...eventList,
        ...await EventApi.getEventList({
          'pageNum': pageNum.value,
          'pageSize': pageSize.value,
        })
      ];
    } else {
      eventList.value = await EventApi.getEventList({
        'pageNum': pageNum.value,
        'pageSize': pageSize.value,
      });
    }
    update(['g-products-list']);
  }

  /// 初始化函数
  @override
  onInit() async {
    super.onInit();
    await load();
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