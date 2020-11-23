
import 'package:json_annotation/json_annotation.dart';
import 'package:haku_app/utils/tool.dart';

part 'event_model.g.dart';

/// 活动类
@JsonSerializable(nullable: false)
class EventModel {

  EventModel({this.id, this.sportGenreId, this.sportGenreName, this.title, this.subTitle, this.isContest, this.eventStartTime, this.eventEndTime, this.startRegisterTime, this.endRegisterTime, this.status, this.address, this.details, this.clubName, this.clubPhone, this.isPrivate, this.coverUrl, this.compilation, this.miniPeople, this.maxPeople, this.price, this.isCancel});

  /// Id
  final String id;
  /// 活动分类Id
  final String sportGenreId;
  /// 活动分类名称
  final String sportGenreName;
  /// 活动标题
  final String title;
  /// 活动副标题
  final String subTitle;
  /// 是否是比赛
  final bool isContest;
  /// 活动开始时间
  final DateTime eventStartTime;
  /// 活动结束时间
  final DateTime eventEndTime;
  /// 报名开始时间
  final DateTime startRegisterTime;
  /// 报名结束时间
  final DateTime endRegisterTime;
  /// 活动状态
  final String status;
  /// 活动地址
  final String address;
  /// 活动详情
  final String details;

  /// 俱乐部名称
  final String clubName;
  /// 俱乐部电话
  final String clubPhone;
  /// 是否俱乐部内部活动
  final bool isPrivate;
  /// 封面图
  final List<String> coverUrl;
  /// 队伍编制
  final String compilation;
  /// 最小人数
  final int miniPeople;
  /// 最大人数
  final int maxPeople;
  /// 报名费用
  final double price;
  /// 活动是否已取消
  final bool isCancel;

  static EventModel fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);
  
  static Map<String, dynamic> toJson(EventModel obj) => _$EventModelToJson(obj);
}