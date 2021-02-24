import 'package:common_utils/common_utils.dart';
import 'package:haku_app/component/index.dart';
import 'package:haku_app/theme/theme.dart';
import 'package:haku_app/utils/global.dart';
import 'package:haku_app/utils/extension.dart';
import 'package:haku_app/utils/tool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'img.dart';
import 'resource_model.dart';

/// 素材小部件
class ResourceList extends StatefulWidget {

  /// 文件夹列表
  final List<ResourceFolder> folderList;
  /// 文件列表
  final List<ResourceFile> fileList;
  /// 允许选择
  final bool canSelect;
  /// 允许下载
  final bool canDownload;
  /// 是否使用网格呈现
  final MaterialItemShape shape;
  /// 已选文件Ids
  final List<dynamic> selectedIds;
  /// 内边距
  final EdgeInsetsGeometry padding;
  /// 外边距
  final EdgeInsetsGeometry margin;
  /// 选择事件
  final void Function(dynamic id, bool isSelected, List<dynamic> selectedList) onSelected;
  /// 文件点击事件
  final void Function(ResourceFile file) onFileTap;
  /// 文件夹点击事件
  final void Function(ResourceFolder folder) onFolderTap;
  /// 动作
  final List<ToolAction> actions;
  /// 滚动方式
  final ScrollPhysics physics;

  ResourceList({
    Key key,
    this.shape = MaterialItemShape.list,
    this.fileList = const [],
    this.folderList = const [],
    this.selectedIds = const [],
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.canSelect = true,
    this.canDownload = true,
    this.onSelected,
    this.onFileTap,
    this.onFolderTap,
    this.actions,
    this.physics: const NeverScrollableScrollPhysics()
  }) : super(key: key);

  @override
  ResourceListState createState() => ResourceListState();
}

class ResourceListState extends State<ResourceList> with WidgetsBindingObserver {

  /// 下放弹出框控制器
  PersistentBottomSheetController bottemSheetController;
  /// 是否显示bottemSheet
  bool showSheet = false;

  @override
  void initState() {
    super.initState();
  }

  /// 选择项
  void selectItem(dynamic id) {
    if (widget.canSelect) {
      final int itemIndex = widget.selectedIds.indexOf(id);
      if (itemIndex >= 0) {
        widget.selectedIds.remove(id);
      } else {
        widget.selectedIds.add(id);
      }
      showSheet = widget.selectedIds.length > 0;
      setState(() {});
      if (widget.onSelected != null) {
        widget.onSelected(id, itemIndex < 0, widget.selectedIds);
        setState(() {});
      }
    }
  }

  /// 获取状态文本
  Widget getStateText(ResourceFile item) {
    switch(item.state) {
      case MaterialItemState.download:
        if (item.downLoadState == DownloadTaskStatus.undefined) {
          return Text('未开始');
        } else if (item.downLoadState == DownloadTaskStatus.running) {
          return Text('${item.progress.toString()}%');
        } else if (item.downLoadState == DownloadTaskStatus.paused) {
          return Wrap(
            children: [
              Text('暂停', style: TextStyle(fontSize: 12, height: 1.3))
            ],
          );
        }
        break;
      case MaterialItemState.normal:
        return Text('');
      case MaterialItemState.upload:
        return Text('');
    }
    return Text('');
  }

  /// 获取运行状态图标
  Widget getRunStateIcon(ResourceFile item) {
    if (item.downLoadState == DownloadTaskStatus.running) {
      return Icon(
        LineIcons.pause,
        color: currentTheme.primaryColor,
      );
    } else if (item.downLoadState == DownloadTaskStatus.paused) {
      return Icon(
        LineIcons.play,
        color: currentTheme.primaryColor,
      );
    } else if (item.downLoadState == DownloadTaskStatus.failed) {
      return Icon(
        LineIcons.exclamation_triangle,
        color: currentTheme.dangerColor,
      );
    } else if (item.downLoadState == DownloadTaskStatus.enqueued) {
      return Icon(
        LineIcons.exclamation_triangle,
        color: currentTheme.dangerColor,
      );
    } else if (item.downLoadState == DownloadTaskStatus.canceled) {
      return Icon(
        LineIcons.reply,
        color: currentTheme.primaryColor,
      );
    } else if (item.downLoadState == DownloadTaskStatus.complete) {
      return Icon(
        LineIcons.check,
        color: currentTheme.primaryColor,
      );
    }
    return Icon(
      LineIcons.android,
      color: currentTheme.primaryColor,
    );
  }

  Widget getRightWidgetForFolder(ResourceFolder item) {
    if (widget.canSelect && widget.onSelected != null) {
      return InkWell(
        child: Container(
          width: 46,
          height: 46,
          child: Checkbox(
            value: widget.selectedIds.indexOf(item.id) >= 0, 
            onChanged: (val) {
              selectItem(item.id);
            }
          ),
        ),
        onTap: () {
          selectItem(item.id);
        },
      );
    }
    return SizedBox();
  }

  /// 返回右侧小部件（网格则为整体覆盖）
  Widget getRightWidgetForFile(ResourceFile item) {
    if (item.state == MaterialItemState.download) {
      return InkWell(
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            // color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: getRunStateIcon(item),
        ),
        onTap: () {
          tapEventByFile(item);
        },
      );
    } else if (item.state == MaterialItemState.normal) {
      if (widget.canSelect && widget.onSelected != null) {
        return InkWell(
          child: Container(
            width: 46,
            height: 46,
            child: Checkbox(
              value: widget.selectedIds.indexOf(item.id) >= 0, 
              onChanged: (val) {
                selectItem(item.id);
              }
            ),
          ),
          onTap: () {
            selectItem(item.id);
          },
        );
      }
    } else {

    }
    return SizedBox();
  }

  List<Widget> getLabelInfo(ResourceFile item) {
    switch(item.state) {
      case MaterialItemState.download:
        return [
          Icon(LineIcons.download, size: 14, color: currentTheme.primaryColor),
          Text(getSizeStr(item.fileSize * (item.progress == null || item.progress.isNaN ? 0 : item.progress) / 100) + ' / ' + getSizeStr(item.fileSize), style: currentTheme.secondaryTextStyle),
        ];
      case MaterialItemState.upload: return [];
      case MaterialItemState.normal:
        return [
          Text(DateUtil.formatDate(item.createTime, format: 'yyyy-MM-dd HH:mm'), style: currentTheme.secondaryTextStyle),
          Text(getSizeStr(item.fileSize), style: currentTheme.secondaryTextStyle),
        ];
      default: return [];
    }
  }

  /// 文件夹点击事件
  tapEventByFolder(ResourceFolder folder) {
    if (widget.onFolderTap != null) widget.onFolderTap(folder);
  }

  /// 文件点击事件
  tapEventByFile(ResourceFile item) async {
    if (widget.onFileTap != null) widget.onFileTap(item);
    // if (widget.selectedIds.length > 0) {
    //   selectItem(item.id);
    // } else {
    //   if (item.url == null || item.url.isBlank) {

    //   } else if (item.state == MaterialItemState.normal) {
    //     File _file = File(Global.defaultDir.path + item.url.substring(item.url.lastIndexOf('/')));
    //     if (await _file.exists()) {
    //       switch(_file.path.substring(_file.path.lastIndexOf('.') + 1)) {
    //         case 'pdf':
    //           Get.to(PDFViewer(
    //             path: _file.path,
    //           ));
    //           break;
    //         default: OpenFile.open(_file.path);
    //       }
    //     } else {
    //       selectItem(item.id);
    //     }
    //   } else if (item.state == MaterialItemState.download) {
    //     if (item.downLoadState == DownloadTaskStatus.running) {
    //       FlutterDownloader.pause(taskId: item.taskId);
    //       item.downLoadState = DownloadTaskStatus.paused;
    //     } else if (item.downLoadState == DownloadTaskStatus.paused) {
    //       String taskId = await FlutterDownloader.resume(taskId: item.taskId);
    //       item.taskId = taskId;
    //       item.downLoadState = DownloadTaskStatus.running;
    //     } else if (item.downLoadState == DownloadTaskStatus.failed) {
    //       String taskId = await FlutterDownloader.retry(taskId: item.taskId);
    //       item.taskId = taskId;
    //       item.downLoadState = DownloadTaskStatus.running;
    //     } else if (item.downLoadState == DownloadTaskStatus.enqueued) {
    //       FlutterDownloader.cancel(taskId: item.taskId);
    //       item.state = MaterialItemState.normal;
    //       item.progress = 0;
    //       item.downLoadState = DownloadTaskStatus.canceled;
    //     }
    //   } else if (item.state == MaterialItemState.upload) {

    //   }
    // }
  }

  /// 生成列表项文件夹
  Widget getMaterialListItemByFolder(ResourceFolder item) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 13
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Img(getFolderIcon(),
                width: 50,
                padding: EdgeInsets.only(
                  right: 10
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.folderName, style: currentTheme.headTextStyle),
                  SizedBox( height: 4, ),
                ],
              ),
            )
          ),
          getRightWidgetForFolder(item),
        ],
      ),
    );
  }

  /// 生成列表项文件
  Widget getMaterialListItemByFile(ResourceFile item) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Stack(
            children: [
              Img(item.thumbnailUrl ?? getMaterialIcon(item.fileName, url: item.url),
                width: 50,
                padding: EdgeInsets.only(
                  right: 10
                ),
              ),
              item.state != MaterialItemState.normal ? Positioned(
                top: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only( right: 10 ),
                  color: Color(0xAAFFFFFF),
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: item.progress / 100,
                    ),
                  ),
                ),
              ): SizedBox()
            ],
          ),
          // Img(item.thumbnailUrl ?? (item.isFile ? getMaterialIcon(item.fileName) : getFolderIcon()),
          //   width: 50,
          //   padding: EdgeInsets.only(
          //     right: 10
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.fileName, style: currentTheme.headTextStyle),
                  SizedBox( height: 4, ),
                  Wrap(
                    spacing: 8,
                    children: getLabelInfo(item),
                  ),
                ],
              ),
            )
          ),
          getRightWidgetForFile(item),
        ],
      ),
    );
  }

  /// 生成网格项文件夹
  Widget getMaterialGridItemByFolder(ResourceFolder item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color(0xFFEEEEEE),
            style: BorderStyle.solid,
            width: 0.5
          ),
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            style: BorderStyle.solid,
            width: 0.5
          )
        )
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: 0,
            bottom: 12,
            child: Img(getFolderIcon(),
              width: 70,
            ),
          ),
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Container(
              height: 34,
              padding: EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.topCenter,
              child: Text(item.folderName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF666666),
                )
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: getRightWidgetForFolder(item),
          ),
        ],
      ),
    );
  }

  /// 生成网格项文件
  Widget getMaterialGridItemByFile(ResourceFile item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color(0xFFEEEEEE),
            style: BorderStyle.solid,
            width: 0.5
          ),
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            style: BorderStyle.solid,
            width: 0.5
          )
        )
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: 0,
            bottom: 20,
            child: Img(item.thumbnailUrl ?? getMaterialIcon(item.fileName, url: item.url),
              width: 70,
            ),
          ),
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Container(
              height: 34,
              padding: EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.topCenter,
              child: Text(item.fileName, 
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF666666)
                )
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              color: Color(0xAAFFFFFF),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xBBF5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xFFCCCCCC),
                  strokeWidth: 6,
                  value: item.progress / 100,
                ),
              ),
            ),
          ).visible(item.state != MaterialItemState.normal),
          Positioned(
            top: 0,
            right: 0,
            child: getRightWidgetForFile(item),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              child: Text(item.progress.toString() + '%', style: TextStyle(
                fontSize: 16
              ),),
            ),
          ).visible(item.state != MaterialItemState.normal)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: widget.margin,
        padding: EdgeInsets.only(
          bottom: showSheet ? 50 : 0
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 0.5
            )
          )
        ),
        child: widget.shape == MaterialItemShape.list ? ListView.separated(
          shrinkWrap: false,
          itemCount: widget.folderList.length + widget.fileList.length,
          physics: widget.physics,
          separatorBuilder: (BuildContext context, int index) => Container(
            child: Divider(height: 1.0, color: Color(0xFFCCCCCC)),
          ),
          itemBuilder: (context, index) => InkWell(
            onTap: () async {
              index < widget.folderList.length ? tapEventByFolder(widget.folderList[index]) : tapEventByFile(widget.fileList[index - widget.folderList.length]);
            },
            child: index < widget.folderList.length ? getMaterialListItemByFolder(widget.folderList[index]) : getMaterialListItemByFile(widget.fileList[index - widget.folderList.length]),
          )
        ) : GridView.builder(
          shrinkWrap: true,
          itemCount: widget.folderList.length + widget.fileList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            onTap: () async {
              index < widget.folderList.length ? tapEventByFolder(widget.folderList[index]) : tapEventByFile(widget.fileList[index - widget.folderList.length]);
            },
            child: index < widget.folderList.length ? getMaterialGridItemByFolder(widget.folderList[index]) : getMaterialGridItemByFile(widget.fileList[index - widget.folderList.length])
          ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            mainAxisSpacing: 0,
            //横轴间距
            crossAxisSpacing: 0,
            //子组件宽高长度比例
            childAspectRatio: 1.0
          ),
        )
      ),
      bottomSheet: Visibility(
        visible: showSheet,
        child: Container(
          padding: EdgeInsets.only(
            top: 6,
            right: 6,
            bottom: 6,
            left: 6
          ),
          decoration: BoxDecoration(
            color: currentTheme.primaryColor,
            border: Border(
              top: BorderSide(
                width: 1,
                color: Color(0xFFDDDDDD)
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...widget.actions.where((item) => item.visible).toList().sublist(0, 3).map((action) => Expanded(
                flex: 1,
                child: InkWell(
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(action.icon, color: Colors.white),
                        Text(action.text, style: TextStyle(
                          fontSize: 12,
                          color: Colors.white
                        ),)
                      ],
                    ),
                  ),
                  onTap: action.onTap,
                )
              )).toList(),
              Visibility(
                visible: widget.actions.where((item) => item.visible).toList().length > 3,
                child: Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LineIcons.ellipsis_h, color: Colors.white),
                          Text('其他', style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          ),)
                        ],
                      ),
                    ),
                    onTap: () {
                      if (widget.actions.where((item) => item.visible).toList().length > 3) {
                        showMaterialModalBottomSheet(
                          context: context,
                          expand: false,
                          builder: (context) => ListView(
                            shrinkWrap: true,
                            controller: ModalScrollController.of(context),
                            children: ListTile.divideTiles(
                              color: Colors.white,
                              context: context,
                              tiles: widget.actions.where((item) => item.visible).toList().sublist(3).map((action) => ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: Container(
                                  alignment: Alignment.centerRight,
                                  width: 40,
                                  height: 40,
                                  child: Icon(action.icon),
                                ),
                                title: Text(action.text),
                                onTap: action.onTap
                              )),
                            ).toList(),
                          ),
                        );
                      }
                    },
                  )
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
