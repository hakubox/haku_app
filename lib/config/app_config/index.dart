import 'app_config_prod.dart' as prod;
import 'app_config_dev.dart' as dev;

/// `基础配置` 是否为开发环境
final bool is_prod = bool.fromEnvironment('dart.vm.product');

/// `基础配置` APP Key
// ignore: non_constant_identifier_names
String get app_key => is_prod ? prod.app_key : dev.app_key;

/// `基础配置` 服务器基础地址
// ignore: non_constant_identifier_names
String get api_base_url => is_prod ? prod.api_base_url : dev.api_base_url;

/// `基础配置` 接口请求加密Key
// ignore: non_constant_identifier_names
String get api_key => is_prod ? prod.api_key : dev.api_key;
