
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

/// 文件夹
class DirectoryManager {
  
  /// 本地路径
  static get localPath async {
    var directory;
    if (GetPlatform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
    }
    return directory.path;
  }


}