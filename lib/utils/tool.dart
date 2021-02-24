import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:get/get.dart';
import 'package:haku_app/model/page_list.dart';
import 'package:haku_app/packages/barcode_scan/barcode_scan.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:haku_app/component/index.dart';
import 'package:haku_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:haku_app/theme/theme.dart';
import 'dart:math';

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
  if (data == null) data = [];
  return data.map((e) => fromJson(e)).toList();
}

/// 转换Map为分页实体类列表
PageList<T> transformPageList<T>(Map<String, dynamic> data, T fromJson(Map<String, dynamic> state)) {
  return PageList(
    total: data['total'],
    list: data.containsKey('list') && data['list'].length > 0 ? data['list'].map<T>((item) => fromJson(item)).toList() : []
  );
}

/// 获取文件大小字符串
String getSizeStr(double filesize) {
  String fileSizeMsg = '';
  try {
    if (filesize < 1048576) fileSizeMsg = (filesize / 1024).toStringAsFixed(1) + " KB";
    else if (filesize >= 1048576 && filesize < 1073741824) fileSizeMsg = (filesize / (1024 * 1024)).toStringAsFixed(1) + " MB";
    else if (filesize >= 1073741824 && filesize < 1099511627776) fileSizeMsg = (filesize / (1024 * 1024 * 1024)).toStringAsFixed(1) + " GB";
  } catch(e) {
    Log.error(e);
    return 'error';
  }
  return fileSizeMsg;
}
  
/// 获取文件夹图标
String getFolderIcon([String baseUrl = 'assets/img/material/file/']) {
  return baseUrl + 'folder.png';
}

/// 获取素材图标
String getMaterialIcon(String fileName, {
  String baseUrl = 'assets/img/material/file/',
  String url,
  int priviewWidth = 160
}) {
  final String suffix = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
  String iconPath = '';
  String previewUrl = null;

  switch(suffix) {
    case 'ai':
      iconPath = 'ai.png';
      break;
    case 'psd':
      iconPath = 'psd.png';
      break;
    case 'txt':
    case 'md':
      iconPath = 'txt.png';
      break;
    case 'html':
    case 'htm':
    case 'json':
    case 'xml':
    case 'js':
    case 'ts':
    case 'dart':
    case 'css':
      iconPath = 'html.png';
      break;
    case 'jpg':
    case 'jpeg':
    case 'bmp':
      previewUrl = ossReduce(url);
      // iconPath = 'jpg.png';
      break;
    case 'png':
      previewUrl = ossReduce(url);
      // iconPath = 'png.png';
      break;
    case 'gif':
      iconPath = 'gif.png';
      break;
    case 'pdf':
    case 'fdf':
    case 'ppdf':
      iconPath = 'ppt.png';
      break;
    case 'mp3':
    case 'midi':
    case 'wav':
    case 'wma':
      iconPath = 'mp.png';
      break;
    case 'ppt':
    case 'pptx':
      iconPath = 'ppt.png';
      break;
    case 'doc':
    case 'docx':
      iconPath = 'word.png';
      break;
    case 'xls':
    case 'xlsx':
      iconPath = 'excel.png';
      break;
    case 'zip':
    case 'rar':
    case '7z':
    case 'iso':
      iconPath = 'zip.png';
      break;
    case 'mp4':
    case 'avi':
    case 'mkv':
    case 'wmv':
      previewUrl = ossReduce(url);
      // iconPath = 'video.png';
      break;
    default:
      iconPath = 'white.png';
  }
  return previewUrl ?? baseUrl + iconPath;
}

/// 下载文件
Future<ResourceFile> downloadFile(ResourceFile file) async {
  file.state = MaterialItemState.download;
  file.progress = 0;
  file.taskId = await FlutterDownloader.enqueue(
    url: file.url,//下载地址
    savedDir: Global.defaultDir.path,
    showNotification: true,
    openFileFromNotification: true,
  );
  return file;
}

/// 选择日期
Future<DateTime> selectDate({
  DateTime initialDate,
  BuildContext context,
  DateTime minDate,
  DateTime maxDate
}) async {
  if (initialDate == null) initialDate = DateTime.now();
  if (minDate == null) minDate = DateTime(1975, 1, 1);
  if (maxDate == null) maxDate = DateTime(2099, 12, 31);
  return await showDatePicker(
    context: context ?? Get.context,
    //定义控件打开时默认选择日期
    initialDate: initialDate,
    //定义控件最早可以选择的日期
    firstDate: minDate,
    //定义控件最晚可以选择的日期
    lastDate: maxDate,
    locale: Get.locale,
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: currentTheme.getTheme(),
        child: child,
      );
    },
  );
}

/// 选择手机里的照片
selectImage() {
  
}

/// oss压缩
ossReduce(String fileName, {
  int width = 200,
  int clarity = 90,
  int frames = 7000
}) {
  if (fileName == null || fileName.isBlank) return '';
  
  var suffix = fileName.substring(fileName.lastIndexOf('.') + 1);
  if (['jpg', 'jpeg', 'png', 'bmp', 'gif', 'webp'].contains(suffix)) {
    return fileName + '?x-oss-process=image/resize,w_${width}/quality,q_${clarity}';
  } else if (['mp4', 'avi', 'mkv', 'wmv'].contains(suffix)) {
    return fileName + '?x-oss-process=video/snapshot,t_${frames},f_jpg,w_${width},h_${width},m_fast';
  }
}