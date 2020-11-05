
import 'log_storage.dart';
import 'stacktrace_processor.dart';
import 'ansi_color.dart';

/// 获取时间
String getLogTimeStr(DateTime time) {
  String _threeDigits(int n) {
    if (n >= 100) return '$n';
    if (n >= 10) return '0$n';
    return '00$n';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  var now = DateTime.now();
  var h = _twoDigits(now.hour);
  var min = _twoDigits(now.minute);
  var sec = _twoDigits(now.second);
  var ms = _threeDigits(now.millisecond);
  var timeSinceStart = now.difference(time).toString();
  return '[${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} $h:$min:$sec.$ms]'; // (+$timeSinceStart)
}

/// 日志级别
enum Level {
  /// 调试
  debug,
  /// 普通消息
  log,
  /// 信息
  info,
  /// 警告
  warn,
  /// 错误
  error,
  /// 严重错误
  wtf,
}

/// 日志
class Log {

  /// 文件日志
  static final LogsStorage _storage = LogsStorage.instance;

  /// 堆栈打印行数
  static int stacktraceLength = 4;

  /// 对应等级的颜色
  static final levelColors = {
    Level.log: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(12),
    Level.warn: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  /// 对应等级的图标
  static final levelEmojis = {
    Level.log: '🧾',
    Level.debug: '🐛',
    Level.info: '💡',
    Level.warn: '⚠️',
    Level.error: '⛔',
    Level.wtf: '👾',
  };

  /// 对应等级的标题
  static final levelTitle = {
    Level.log: 'LOG',
    Level.debug: 'DEBUG',
    Level.info: 'INFO',
    Level.warn: 'WARN',
    Level.error: 'ERROR',
    Level.wtf: '!WTF!',
  };

  /// 打印文本
  static log(String str) {
    _print(str, Level.log);
  }

  /// 打印普通信息
  static info(String str) {
    _print(str, Level.info);
  }

  /// 打印警告信息（包含调用堆栈）
  static warn(String str, [StackTrace stackTrace]) {
    _print(str, Level.warn, null, stackTrace);
  }

  /// 打印错误信息（包含错误及调用堆栈）
  static error(String str, [dynamic error, StackTrace stackTrace]) {
    _print(str, Level.error, error, stackTrace);
  }

  /// 打印严重错误信息（包含错误及调用堆栈）
  static wtf(String str, [dynamic error, StackTrace stackTrace]) {
    _print(str, Level.wtf, error, stackTrace);
  }

  /// 打印
  static _print(String str, Level level, [dynamic error, StackTrace stackTrace]) {
    AnsiColor color = levelColors[level];
    String log = '${getLogTimeStr(DateTime.now())} $str';
    _storage.writeLogsToFile('[${levelTitle[level]}] $log');
    print(color('${levelEmojis[level]} $log'));

    if ([Level.error,Level.wtf].contains(level) && error != null) {
      for (var line in error.split('\n')) {
        _storage.writeLogsToFile(line);
        print(color.resetForeground + color(line) + color.resetBackground);
      }
    }
    
    if ([Level.warn,Level.error,Level.wtf].contains(level)) {
      String stackTraceStr = StacktraceProcessor.formatStackTrace(stackTrace ?? StackTrace.current, stacktraceLength);
      for (var line in stackTraceStr.split('\n')) {
        _storage.writeLogsToFile(line);
        print('$color $line');
      }
    }
  }
}