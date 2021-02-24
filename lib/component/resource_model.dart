import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

/// 文件状态
enum MaterialItemState {
  /// 正常
  normal,
  /// 下载中
  download,
  /// 上传中
  upload,
}

/// 资源展现形式
enum MaterialItemShape {
  /// 列表
  list,
  /// 网格
  grid,
}

/// 动作图标
class ToolAction {
  /// 图标
  final IconData icon;
  /// 文本
  final String text;
  /// 是否显示
  final bool visible;
  /// 点击事件
  final void Function() onTap;

  const ToolAction({
    this.icon,
    this.text,
    this.visible = true,
    this.onTap
  });
}

/// 素材文件夹
class ResourceFolder {
  /// Id
  dynamic id;
  /// 父级文件夹Id
  String parentId;
  /// 评级
  int level;
  /// 是否为私有文件夹
  bool isLock;
  /// 文件夹名称
  String folderName;
  /// 创建时间
  DateTime createTime;
  /// 创建人账号
  String createUserName;
  /// 创建人Id
  String createUserId;
  /// 创建人头像
  String createUserHeadImg;
  /// 文件列表
  List<ResourceFile> fileList;
  /// 子文件夹列表
  List<ResourceFolder> folderList;

  ResourceFolder({
    this.id,
    this.parentId,
    this.level,
    this.folderName,
    this.isLock = false,
    this.createTime,
    this.createUserName,
    this.createUserId,
    this.createUserHeadImg,
    this.fileList = const [],
    this.folderList = const []
  });
}

/// 素材文件
class ResourceFile {
  /// Id
  String id;
  /// 父级文件夹Id
  String parentId;
  /// 评级
  int level;
  /// 是否为私有文件
  bool isLock;
  /// 文件状态
  MaterialItemState state;
  /// 下载状态
  DownloadTaskStatus downLoadState = DownloadTaskStatus.undefined;
  /// 文件名
  String fileName;
  /// 创建时间
  DateTime createTime;
  /// 文件大小
  double fileSize;
  /// 文件地址
  String url;
  /// 文件缩略图地址
  String thumbnailUrl;
  /// 任务Id
  String taskId;
  /// 任务进度
  int progress;
  /// 创建人账号
  String createUserName;
  /// 创建人Id
  String createUserId;
  /// 创建人头像
  String createUserHeadImg;
  /// 备注
  String remark;
  /// 父级文件夹Id
  String folderId;

  ResourceFile({ 
    this.id, 
    this.parentId,
    this.level = 0,
    this.isLock = false,
    this.state = MaterialItemState.normal,
    this.downLoadState = DownloadTaskStatus.undefined,
    this.fileName = '',
    this.createTime, 
    this.fileSize = 0.0,
    this.url,
    this.thumbnailUrl,
    this.taskId,
    this.progress = 0,
    this.createUserName,
    this.createUserId,
    this.createUserHeadImg,
    this.remark = '',
    this.folderId
  });
}

/// 历史访问文件
class VisitResourceFile {

  /// 最后访问时间
  final DateTime visitTime;
  /// 文件
  final ResourceFile file;

  VisitResourceFile({ 
    this.visitTime,
    this.file,
  });
}