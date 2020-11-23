import 'package:haku_app/packages/log/log.dart';
import 'package:permission_handler/permission_handler.dart';

/// 功能权限
class FeaturePermission {

  /// 权限名称
  static Map<Permission, String> permissionEnum = {};

  /// 获取权限名称
  @deprecated
  static String getPermissionName() {
    return '';
  }

  /// 请求权限
  static bool request(String permission) {
    if ((permission ?? '').trim().isEmpty) {
      return true;
    } else if (1 == 1) {
      return true;
    } else {
      var _exception = PermissionException(permission);
      Log.error(_exception.toString());
      throw _exception;
    }
  }

  /// 请求权限
  @deprecated
  static bool requestAll(List<String> permissions) {
    throw Exception('功能未完成');
  }
}

//自定义错误提示
class PermissionException implements Exception {
  String permissionName;
  String msg;

  PermissionException(this.permissionName, [this.msg]);

  @override
  String toString() {
    return '当前用户无[' + permissionName + ']权限' + (msg.isNotEmpty ? '\n详细信息：' + msg : '');
  }
}