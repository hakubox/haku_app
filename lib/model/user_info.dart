import 'package:json_annotation/json_annotation.dart';

/// 用户类
@JsonSerializable(nullable: false)
class UserInfo {
  /// Id
  final String id;
  /// 姓名
  final String name;
  /// 年龄
  final int age;
  /// 用户名
  final String username;

  const UserInfo({ this.id, this.name, this.age, this.username });
}