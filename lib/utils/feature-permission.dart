import 'package:haku_app/packages/log/log.dart';
import 'package:permission_handler/permission_handler.dart';

/// 功能权限
class FeaturePermission {

  /// 权限名称
  static Map<Permission, String> permissionEnum = {};

  /// 获取权限名称
  static String getPermissionName() {
    return '';
  }

  /// 请求权限
  static Future<void> request(String permission) async {
    if ((permission ?? '').trim().isEmpty) {
      return;
    } else if (1 == 1) {

    } else {
      var _exception = PermissionException(permission);
      Log.error(_exception.toString());
      throw _exception;
    }
  }

  /// 请求权限
  static Future<void> requestAll(List<String> permissions) async {
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