import 'package:haku_app/model/user_model.dart';
import 'package:haku_app/utils/http-util.dart';

/// 用户相关Api
class UserApi {
  /// 获取全部用户
  getAll([HttpOptions options]) async {
    return HttpUtil.get('User/getAll');
  }
  /// 根据 `Id` 获取用户
  getId(String id, [HttpOptions options]) async {
    return HttpUtil.get('User/getId', { 'id': id });
  }
  /// 移除用户
  delete(String id, [HttpOptions options]) async {
    return HttpUtil.delete('User/DeleteUser', { 'id': id });
  }
  /// 编辑用户
  edit(UserModel user, [HttpOptions options]) async {
    return HttpUtil.post('User/edit', user, options);
  }
  /// 新增用户
  add(UserModel user, [HttpOptions options]) async {
    return HttpUtil.post('User/add', user, options);
  }
}