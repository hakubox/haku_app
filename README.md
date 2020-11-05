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

// 切换语言
var locale = Locale('en', 'US');
Get.updateLocale(locale);

// 切换主题
Get.changeTheme(ThemeData.light());

```

### 其他Get库常用函数

[https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md#%E5%85%B6%E4%BB%96%E9%AB%98%E7%BA%A7api)

## 第三方代码规范（供参考）

[https://github.com/AlexV525/effective_flutter/blob/master/rules.md](https://github.com/AlexV525/effective_flutter/blob/master/rules.md)

## 约定

1. 不可开启自动换行，保证所有格式化都手动完成。
2. 不可在项目中自定义颜色，必须使用主题已定义颜色。
3. 所有在 `pubspec.yaml` 中引入的第三方库都应该有其基本说明。
4. 尽量避免在页面中定义局部变量，使用 `fish_redux` 完成。
5. 不要写 `new` 关键字。

## 各文件夹职责

文件夹名 | 功能 | 备注
-- | -- | --
component | 组件库 | 放置例如下拉框、搜索框等等独立组件
lang | 多语言 | 用于放置多语言文件
model | 实体类 | 用于放置项目所需的dto实体类
page | 页面 | 用于放置项目所需页面，注：包含页面相关 `Adapter`
theme | 主题 | 用于定制系统的各个不同主题
tool | 工具类 | 例如网络请求或其他各类工具函数等
assets | 静态资源 | 所有静态资源的文件夹（例如图片/字体等）

## 第三方库链接

- [GetX](https://pub.flutter-io.cn/packages/get/example)
- [Fliggy-Mobile](https://github.com/Fliggy-Mobile)