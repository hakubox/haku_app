import 'dart:ui';

/// App生命周期
AppLifecycleState _state;

/// App生命周期函数
class AppLifecycle {

  /// 改写App当前状态
  static set state(AppLifecycleState state) => _state;

  /// App生命周期
  static get state => _state;

  /// 监听App生命周期
  static listen(void event(AppLifecycleState state)) {
    event(_state);
  }

}