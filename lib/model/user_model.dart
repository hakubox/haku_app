import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// 用户类
@JsonSerializable(nullable: false)
class UserModel {

  /// Id
  final String id;
  /// 姓名
  final String name;
  /// 年龄
  final int age;

  /// 用户名
  final String username;

  const UserModel({ this.id, this.name, this.age, this.username });

  static UserModel fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  static Map<String, dynamic> toJson(UserModel obj) => _$UserModelToJson(obj);
}