
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'log.dart';

class LogsStorage {
  /// Singleton constructor
  static final LogsStorage _singleton = LogsStorage._();

  /// Singleton accessor
  static LogsStorage get instance => _singleton;

  /// A private constructor. Allows us to create instances of LogsStorage
  /// only from within the LogsStorage class itself.
  LogsStorage._() {
    deleteExpireLog();
  }

  /// get log print path
  Future<String> get _localPath async {
    var directory;

    if (GetPlatform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
    }

    return directory.path;
  }

  /// file
  File _file;

  /// get log print file
  Future<File> get _localFile async {
    final path = await _localPath + "/flogs/";

    //creating directory
    Directory(path).create()
        // The created directory is returned as a Future.
        .then((Directory directory) {
      print(directory.path);
    });

    //opening file
    var file = File("$path${getLogTimeStr(DateTime.now())}.log");
    var isExist = await file.exists();

    //check to see if file exist
    if (isExist) {
      print('Log File exists');
    } else {
      print('Log File does not exist ');
    }
    _file = file;
    return file;
  }

  /// write log to file
  void writeLogsToFile(String log) async {
    if (_file == null) {
      await _localFile;
    }
    // Write the file
    _file.writeAsStringSync('$log', mode: FileMode.writeOnlyAppend);
  }

  /// app save five days log , if log expire time delete
  Future deleteExpireLog() async {
    try {
      final path = await _localPath + "/flogs/";
      var fiveDayBefore = DateTime.now().subtract(Duration(days: 5));
      Directory(path).list().where((value) {
        var file = File(value.path);
        if (file == null || !file.existsSync()) {
          return false;
        }
        DateTime dateTime = file.lastModifiedSync();
        print("delete log ${file.path} time=${dateTime.millisecondsSinceEpoch} before=${dateTime.isBefore(fiveDayBefore)}");
        if (dateTime.isBefore(fiveDayBefore)) {
          file.delete();
        }
        return true;
      }).toList();
    } catch (e) {
      print('delete expire time log error');
    }
  }
}