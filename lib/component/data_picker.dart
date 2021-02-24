import 'package:haku_app/component/index.dart';
import 'package:haku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oktoast/oktoast.dart';

import 'img.dart';

/// 选择器项
class DataPickerItem {
  
  /// 值
  final dynamic value;
  /// 标题
  final String title;
  /// 副标题
  final String subTitle;
  /// 图标
  final IconData icon;
  /// 图片地址
  final String imgUrl;

  DataPickerItem({ @required this.value, this.title, this.subTitle, this.icon, this.imgUrl });
}

/// 数据选择器（底部弹出框）
class DataPicker {

  /// 文本浮动层
  static Future<List<DataPickerItem>> show({
    @required List<dynamic> checkedList,
    @required List<DataPickerItem> data,
    BuildContext context,
    double iconSize = 40,
    Color backgroundColor = Colors.white,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    EdgeInsetsGeometry margin = const EdgeInsets.all(50.0),
    Duration duration,
    void Function(dynamic value, bool isChecked, List<dynamic> checkedList) onChange,
    void Function(List<DataPickerItem> checkedList) onSave,
    void Function(List<DataPickerItem> checkedList) onCancel
  }) async {
    List<dynamic> _checkedList = checkedList.map((e) => e).toList();
    return await showCupertinoModalBottomSheet(
      context: context ?? Get.context,
      closeProgressThreshold: 1,
      builder: (context) => Scaffold(
        body: CheckedList(
          data: data,
          initCheckedList: checkedList,
          iconSize: iconSize,
          backgroundColor: backgroundColor,
          onChange: (value, isChecked, ids) {
            _checkedList = ids;
            if (onChange != null) onChange(value, isChecked, ids);
          }
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 15
                  ),
                  child: InkWell(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text('取消', style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),),
                    ),
                    onTap: () {
                      if (onCancel != null) onCancel(data.where((item) => _checkedList.contains(item.value)).toList());
                      Get.back(
                        result: data.where((item) => _checkedList.contains(item.value)).toList()
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: InkWell(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: currentTheme.primaryColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text('确认', style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),),
                    ),
                    onTap: () {
                      if (onSave != null) onSave(data.where((item) => _checkedList.contains(item.value)).toList());
                      Get.back(
                        result: data.where((item) => _checkedList.contains(item.value)).toList()
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}


/// 多选列表
class CheckedList extends StatefulWidget {

  /// 选项列表
  final List<DataPickerItem> data;
  /// 已选项Key列表
  final List<dynamic> initCheckedList;
  /// 图标/图片大小
  final double iconSize;
  /// 背景图
  final Color backgroundColor;
  /// 选择改变事件
  final void Function(dynamic value, bool isChecked, List<dynamic> checkedList) onChange;

  const CheckedList({
    Key key,
    @required this.data,
    this.initCheckedList = const [],
    this.iconSize = 40,
    this.backgroundColor = Colors.white,
    this.onChange
  }) : super(key: key);

  @override
  _CheckedListState createState() => _CheckedListState();
}

class _CheckedListState extends State<CheckedList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 获取左侧组件
  static Widget _getSecondary({
    IconData icon,
    double iconSize = 40,
    String imgUrl,
    Color backgroundColor
  }) {
    if (icon != null) {
      return Container(
        child: Icon(icon, size: iconSize, color: backgroundColor != null ? Colors.white : currentTheme.fontColor),
      );
    } else if (imgUrl != null) {
      return Img(imgUrl, backgroundColor: backgroundColor, width: iconSize, fit: BoxFit.cover, height: iconSize);
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ScrollController(),
      radius: Radius.circular(6),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.data.length,
        separatorBuilder: (BuildContext context, int index) => Container(
          child: Divider(height: 1.0, color: Color(0xFFCCCCCC)),
        ),
        // itemBuilder: (context, index) => Container(
        //   child: Text(data[index].title),
        // )
        itemBuilder: (context, index) {
          var item = widget.data[index];
          return CheckboxListTile(
            value: widget.initCheckedList.contains(item.value),
            secondary: _getSecondary(
              icon: item.icon,
              imgUrl: item.imgUrl,
              iconSize: widget.iconSize,
              backgroundColor: widget.backgroundColor
            ),
            title: Text(item.title),
            subtitle: item.subTitle != null ? Text(item.subTitle) : null,
            selected: widget.initCheckedList.contains(item.value),
            onChanged: (bo) {
              if (bo) widget.initCheckedList.add(item.value);
              else widget.initCheckedList.remove(item.value);
              if (widget.onChange != null) widget.onChange(item.value, bo, widget.initCheckedList);
              setState((){});
            },
          );
        },
      )
    );
  }
}