import 'package:haku_app/utils/http-util.dart';

/// 系统访问授权相关Api
class AuthorizeApi {
  /// 获取Token
  getToken([HttpOptions options]) async {
    return HttpUtil.get('Authorize/GetToken', {}, options);
  }
}