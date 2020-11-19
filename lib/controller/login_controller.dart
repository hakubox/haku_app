import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:haku_app/packages/network_state/network_state.dart';
import 'package:haku_app/utils/feature-permission.dart';
import 'package:haku_app/utils/http-util.dart';

/// 登录控制器
class LoginController extends GetxController {

  /// 用户名
  final RxString username = ''.obs;
  /// 密码
  final RxString password = ''.obs;

  /// 用户名控制器
  // TextEditingController usernameController = TextEditingController();

  bool get usernameIsValid {
    if (username.value.isNotEmpty && username.value.length < 3) return false;
    return true;
  }

  bool get passwordIsValid {
    if (password.value.isNotEmpty && password.value.length < 6) return false;
    return true;
  }

  bool get formLoginIsValid =>
      usernameIsValid &&
      passwordIsValid &&
      username.value.isNotEmpty &&
      password.value.isNotEmpty;

  clearUsername() => this.username.value = '';
  clearPassword() => this.password.value = '';

  changeUsername(String value) => username.value = value;
  changePassword(String value) => password.value = value;

  /// 登录
  login() async {
    this.username.value = '已登录';

    if (formLoginIsValid) {
      Log.info('登录了');

      await FeaturePermission.request('');
      var userInfo = await HttpUtil.post('user/login', {
        'username': username,
        'password': password
      });
    } else {
      Log.error('校验失败');
    }
  }

  /// 注册
  register() {
    HttpUtil.post('user/register', {
      'username': username,
      'password': password
    }).then((value) {

    }).catchError((error) {
      
    });
  }

  /// 初始化函数
  @override
  onInit() {
    super.onInit();
    NetworkState.listen((state) {
      switch(state) {
        case ConnectivityResult.mobile:
        break;
        case ConnectivityResult.wifi:
        break;
        case ConnectivityResult.none:
        break;
      }
    });
  }

  /// 显示后调用
  @override
  onReady() {
    super.onReady();
  }

  /// 销毁后调用
  @override
  onClose() {
    super.onClose();
  }
}