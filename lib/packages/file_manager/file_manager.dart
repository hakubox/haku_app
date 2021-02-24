import 'dart:convert';
import 'dart:io';

import 'package:haku_app/packages/file_manager/directory_manager.dart';

class FileManager {

  /// 文件
  File file;
  /// 是否为完全自定义路径
  bool isCustomPath;

  FileManager(this.file, { this.isCustomPath = false });

  /// 根据路径获取文件
  factory FileManager.path(String path, { isCustomPath = false }) {
    return FileManager(File(isCustomPath ? path : '${DirectoryManager.localPath}$path'));
  }

  /// 判断文件是否存在
  Future<bool> exists() async {
    return file.exists();
  }

  /// 获取文件内容
  Future<String> read([Encoding encoding = utf8]) {
    return file.readAsString(encoding: encoding);
  }

  /// 写入文本内容
  Future<File> write(String content, { FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false }) {
    return file.writeAsString(content, mode: mode, encoding: encoding, flush: flush);
  }
  /// 写入字节流
  Future<File> writeBytes(List<int> bytes, { FileMode mode = FileMode.write, bool flush = false }) {
    return file.writeAsBytes(bytes, mode: mode, flush: flush);
  }

  /// 重命名文件
  Future<File> rename(String newPath) {
    return file.rename(newPath);
  }

  /// 删除文件
  Future<bool> delete(String path, [bool recursive = false]) async {
    File _file = File('${DirectoryManager.localPath}$path');
    if (await _file.exists()) {
      file.delete(recursive: recursive).then((value) {
        return true;
      }).catchError(() {
        return false;
      });
    }
    return false;
  }
}