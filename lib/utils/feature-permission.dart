import 'package:haku_app/utils/log/log.dart';
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
  static Future<bool> request(String permission) async {
    return false;
  }

  /// 请求权限
  static Future<bool> requestAll(List<String> permissions) async {
    return false;
  }
}