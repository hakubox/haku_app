# haku_app

一个以 [`get`](https://pub.dev/packages/get) 为基础的 **flutter** 脚手架。

## 常用命令

```Shell
# 运行
flutter run

# 打包app
flutter build apk
flutter build ios

# 下载第三方库依赖
flutter packages get

# 更新flutter版本
flutter upgrade

# 检测Flutter工具链状态
flutter doctor
```

## 常用函数

```dart
// 创建GetX作用域
Obx(() => Weight);

// 返回主页面（Tab Bar）
Get.offAllNamed(Routes.base);

// 切换语言
var locale = Locale('en', 'US');
Get.updateLocale(locale);

// 切换主题
Get.changeTheme(ThemeData.light());
```

## 常用命令

```bash
# 本机运行
flutter run
# 打包APP（安卓）
flutter build apk
# 检查本机flutter状态
flutter doctor
# 获取所有真机设备包括Ios模拟器
flutter devices
# 将工具链上的库提升到最新版本
flutter upgrade
# 将所有库拉取到本地
flutter packages get
# 生成类（生成g.dart文件）
flutter packages pub run build_runner build
```

### 其他Get库常用函数

[https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md#%E5%85%B6%E4%BB%96%E9%AB%98%E7%BA%A7api)

## 第三方代码规范（供参考）

[https://github.com/AlexV525/effective_flutter/blob/master/rules.md](https://github.com/AlexV525/effective_flutter/blob/master/rules.md)

## 权限列表

> Android权限列表
[https://www.cnblogs.com/diyishijian/p/5629545.html](https://www.cnblogs.com/diyishijian/p/5629545.html)

> Ios权限列表
[https://pub.flutter-io.cn/packages/permission_handler](https://pub.flutter-io.cn/packages/permission_handler)

## 约定

1. 不可开启自动换行，保证所有格式化都手动完成。
2. 不可在项目中自定义颜色，必须使用主题已定义颜色。
3. 所有在 `pubspec.yaml` 中引入的第三方库都应该有其基本说明。
4. 尽量避免在页面中定义局部变量，使用 `fish_redux` 完成。
5. 不要写 `new` 关键字。
6. 尽量避免在page层出现任何业务逻辑。
7. 尽量避免在controller层出现通过字符串url的接口调用。
8. 注意page和controller里的

## 各模块职责

文件夹名 | 功能 | 备注
-- | -- | --
assets | 静态资源 | 所有静态资源的文件夹（例如图片/字体等）
lib/api | 接口封装库 | 用于轻度封装接口调用
lib/component | 组件库 | 放置例如下拉框、搜索框等等独立组件
lib/config | 主要配置 | 包含路由等配置项。
lib/config/app_config | App配置 | App相关所有基础配置项。
lib/locales | 多语言 | 用于放置多语言文件
lib/model | 实体类 | 用于放置项目所需的dto实体类
lib/packages | 功能库 | 用于放置封装的一些功能库，例如网络状态、日志打印等等
lib/packages/log | 日志库 | 用于打印日志
lib/packages/app_lifecycle | App声明周期库 | 
lib/packages/app_router | 路由库 | 用于路由的统一管理
lib/packages/barcode_scan | 条形码扫描 | 
lib/packages/icons | 字体图标相关库 | 
lib/packages/log | 日志打印库 | 
lib/packages/log | 网络状态监控库 | 
lib/page | 页面 | 用于放置项目所需页面/控制器/绑定
lib/theme | 主题 | 用于定制系统的各个不同主题
lib/utils | 工具库 | 例如网络请求或其他各类工具函数等
lib/utils/controller | 基础页面控制器 | 例如网络请求或其他各类工具函数等
lib/utils/cache.dart | 本地缓存库 | 
lib/utils/feature-permission.dart | 功能权限库 | 
lib/utils/global.dart | 公共库 | 用于存放全局公共变量及部分配置
lib/utils/http-util.dart | HTTP请求库 | 用于调用HTTP请求用
lib/utils/sys-permission.dart | 系统权限库 | 用于获取或查看系统权限（例如相机/照片等）
lib/utils/tool.dart | 公共函数库 | 用于存放部分常用公共函数

## 第三方库链接

- [GetX](https://pub.flutter-io.cn/packages/get/example)
- [Fliggy-Mobile](https://github.com/Fliggy-Mobile)

## 第三方图标库

- [Linear Icons](https://linearicons.com/free)

## Ios 开发注意事项

[https://www.jianshu.com/p/f2cb7a7936ef](https://www.jianshu.com/p/f2cb7a7936ef)

## 常用功能文章

[指纹/面容识别认证](https://www.jianshu.com/p/06ba43743b1f)

## mock数据

[JSON Placeholder](https://jsonplaceholder.typicode.com/)