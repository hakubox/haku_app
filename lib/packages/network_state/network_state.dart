import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:haku_app/packages/log/log.dart';

/// 网络监测对象
Connectivity _subscription = Connectivity();
/// 网络监听对象
StreamSubscription<ConnectivityResult> _connectivityResult;


/// 网络状态监控
class NetworkState {

  /// 获取网络状态
  static Future<ConnectivityResult> getNetWorkState() {
    return Future<ConnectivityResult>(() {
      return _subscription.checkConnectivity();
    });
  }

  /// 开始监听
  static listen(void event(ConnectivityResult event)) {
    _connectivityResult = _subscription.onConnectivityChanged.listen((ConnectivityResult result) {
      event(result);
    });
  }

  static cancelListen() {
    _connectivityResult.cancel();
  }

  /// 测试网络状态
  static testNetwork() {
    getNetWorkState().then((value) {
      switch(value) {
        case ConnectivityResult.mobile:
          Log.info('当前为蜂窝网络');
        break;
        case ConnectivityResult.wifi:
          Log.info('当前为Wifi');
        break;
        case ConnectivityResult.none:
          Log.info('当前无网络');
        break;
      }
    });
  }
}