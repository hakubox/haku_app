/// 用户类
class UserModel {

  /// Id
  int id;
  /// 姓名
  String name;
  /// 年龄
  String age;

  UserModel({ id, name, age });

  UserModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'];
      this.age = json['age'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }
}