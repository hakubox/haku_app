/// 缓存个人信息
class ProfileModel {

  /// 用户Id
  int id;
  /// 用户名
  String name;

  ProfileModel({ id, name });

  ProfileModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}