import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:haku_app/model/page_list.dart';
import 'package:haku_app/packages/barcode_scan/barcode_scan.dart';

/// md5 加密
String generateMd5(String data) {
  var content = Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

/// 递归遍历
void recursiveMap(Map<String, dynamic> data, String code, void fn(String key, Map<String, dynamic> data, String code)) {
  data.forEach((key, value) {
    String _code = code.isNotEmpty ? code + '.' + key : key;
    fn(key, data, _code);
    if (value.runtimeType.toString() != "String") {
      recursiveMap(value, _code, fn);
    }
  });
}

/// 递归遍历
// void recursive<T>(List<T> data, {
//   void forEach(T item, List<T> data, { String code }),
//   Map map(T item, { String code }),
//   dynamic filter(T item, { String code }),
// }) {
//   data.forEach((item) {
//     forEach(item, data);
//     if (item.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>") {
//       recursive(item.children, forEach: forEach, map: map, filter: filter);
//     }
//   });
// }


/// 条形码/二维码扫描
Future scan() async {
  // if (!PermissionSetting.listSetting.containsKey('ScanQuery')) {
  //   Toast.show("无权限使用");
  //   return;
  // }

  try {
    var options = ScanOptions(
      strings: {
        "cancel": "取消",
        "flash_on": "闪光灯打开",
        "flash_off": "闪光灯关闭",
      },
    );
    // FocusScope.of(context).requestFocus(FocusNode());
    var result = await BarcodeScanner.scan(options: options);
    return result.rawContent;
  } catch (e) {
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      // Toast.show("请求出错：用户没有授予相机权限!");
    } else {
      // Toast.show("请求出错：$e");
    }
  }
}

/// 转换日期
DateTime parseDate(String date) {
  if (GetPlatform.isAndroid) {
    return DateTime.tryParse(date.replaceAll(RegExp(r'/'), '-'));
  } else if (GetPlatform.isIOS) {
    return DateTime.tryParse(date.replaceAll(RegExp(r'/'), '-'));
  } else {
    return DateTime.tryParse(date);
  }
}
  
/// 转换List<Map>为实体类列表
List<T> transformList<T>(List data, T fromJson(Map<String, dynamic> state)) {
  return data.map((e) => fromJson(e)).toList();
}

/// 转换Map为分页实体类列表
PageList<T> transformPageList<T>(data, T fromJson(Map<String, dynamic> state)) {
  return PageList(
    total: int.tryParse(data.total),
    list: data.list.map((item) => fromJson(item)).toList()
  );
}