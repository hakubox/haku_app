
import 'package:get/get.dart';
import 'package:haku_app/utils/log/log.dart';
import 'package:permission_handler/permission_handler.dart';

/// 系统权限
class SysPermission {

  /// 权限名称
  static Map<Permission, String> permissionEnum = {
    Permission.phone: 'phone',
    Permission.photos: 'photos',
    Permission.storage: 'storage',
    Permission.camera: 'camera',
    Permission.location: 'location',
  };

  /// 获取权限名称
  static String getPermissionName(Permission permission) {
    String platform = '';
    if (GetPlatform.isAndroid) platform = 'android';
    if (GetPlatform.isIOS) platform = 'ios';
    return 'permission_${platform}_${permissionEnum[permission]}'.tr;
  }

  /// 请求权限
  static Future<bool> request(Permission permission) async {
    PermissionStatus status = await permission.status;
    // 未请求许可
    if (status.isGranted) {
      return true;
    } else if (status.isRestricted) {
      Log.error('由于系统限制无法获取 [${getPermissionName(permission)}] 权限！');
      // 操作系统会限制访问，例如由于家长控制。
      return false;
    } else {
      Log.info('正在申请获取 [${getPermissionName(permission)}] 权限...');
      return await permission.request().isGranted;
    }
  }

  /// 请求权限
  static Future<Map<Permission, PermissionStatus>> requestAll(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    String permissionNames = permissions.map((platform) {
      return getPermissionName(platform).tr;
    }).toList().join('/');
    Log.info('正在申请获取 [$permissionNames] 权限...');
    return statuses;
  }
}