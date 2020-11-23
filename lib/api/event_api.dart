import 'package:haku_app/model/event_model.dart';
import 'package:haku_app/model/page_list.dart';
import 'package:haku_app/utils/http-util.dart';
import 'package:haku_app/utils/tool.dart';

/// 活动模块
class EventApi {

  // 示例：

  /// 获取活动列表（不带总条数）
  static Future<List<EventModel>> getEventList([Map<String, dynamic> params, HttpOptions options]) async {
    List re = await HttpUtil.get('Event/GetEventList', params, options);
    return transformList<EventModel>(re, EventModel.fromJson);
  }

  /// 获取活动列表（带总条数）
  static Future<PageList<EventModel>> getEventList2([Map<String, dynamic> params, HttpOptions options]) async {
    return transformPageList<EventModel>(await HttpUtil.get('Event/GetEventList', params, options), EventModel.fromJson);
  }

  /// 根据Id获取活动详情
  static Future<EventModel> getEvent(String id, [HttpOptions options]) async {
    return EventModel.fromJson(await HttpUtil.get('Event/GetEvent', { 'id': id }, options));
  }

  /// 获得体育类型列表
  static Future<List<Map<String, dynamic>>> getSportGenreList([HttpOptions options]) async {
    return await HttpUtil.get('Event/GetSportGenreList', {}, options);
  }
}