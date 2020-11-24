import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';
import 'package:get/get.dart';
import 'package:haku_app/component/button.dart';
import 'package:frefresh/frefresh.dart';
import 'package:haku_app/component/img.dart';
import 'package:haku_app/config/routes/routers.dart';
import 'package:haku_app/model/event_model.dart';
import 'package:haku_app/packages/log/log.dart';
import 'package:haku_app/utils/app_state.dart';

import 'list_controller.dart';

/// 列表页
class ListPage extends GetView<ListController> {

  @override
  Widget build(context) => Scaffold(
    appBar: AppBar(
      title: Text('list.title'.tr),
    ),
    body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Obx(() => Container(
                decoration: BoxDecoration(
                  color: Color(0xFFDDDDDD),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFDDDDDD),
                      width: 0.5
                    )
                  )
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FSuper(
                        width: 200,
                        height: 40,
                        child1: Wrap(
                          children: [
                            Text('参数A'),
                            {
                              '': SizedBox(),
                              'esc': Icon(Icons.arrow_drop_up),
                              'desc': Icon(Icons.arrow_drop_down),
                            }[controller.sortConfig['itemA']['sort']]
                          ],
                        ),
                        onClick: () {
                          Log.info('点击了！！');
                        }
                      ),
                    ),
                    SizedBox(
                      width: 0.5,
                      height: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xFFCCCCCC)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FSuper(
                        width: 200,
                        height: 40,
                        child1: Wrap(
                          children: [
                            Text('参数B'),
                            {
                              '': SizedBox(),
                              'esc': Icon(Icons.arrow_drop_up),
                              'desc': Icon(Icons.arrow_drop_down),
                            }[controller.sortConfig['itemB']['sort']]
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.5,
                      height: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xFFCCCCCC)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FSuper(
                        width: 200,
                        height: 40,
                        child1: Wrap(
                          children: [
                            Text('参数C'),
                            {
                              '': SizedBox(),
                              'esc': Icon(Icons.arrow_drop_up),
                              'desc': Icon(Icons.arrow_drop_down),
                            }[controller.sortConfig['itemC']['sort']]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Expanded(
              flex: 1,
              child: Obx(() {
                if (controller.appState() == AppState.LOADING) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.appState() == AppState.ERROR) {
                  return Center(
                    child: Button(
                      child: Text('AppState ERROR'),
                      onPressed: () => controller.load(),
                    )
                  );
                }
                return buildControllerDemo();
              }),
            )
          ],
        ),
      ),
    ),
  );

  Widget buildControllerDemo() {
    return Container(
      child: FRefresh(
        controller: controller.refreshController,
        header: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            "下拉刷新 √",
            style: TextStyle(color: Color(0xffcfd8dc)),
          ),
        ),
        headerHeight: 40.0,
        footer: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            "加载更多 √",
            style: TextStyle(color: Color(0xffcfd8dc)),
          ),
        ),
        footerHeight: 40,
        onRefresh: () async {
          await controller.load();
          controller.refreshController.finishRefresh();
        },
        onLoad: () async {
          controller.pageNum++;
          await controller.load();
          return true;
        },
        child: Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 9.0, right: 9.0, bottom: 9.0),
            shrinkWrap: true,
            itemCount: controller.eventList.length,
            itemBuilder: (_, index) {
              EventModel item = controller.eventList[index];
              return InkWell(
                child: Container(
                  height: 72,
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC), width: 0.5)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: item.coverUrl.length > 0 ? Img(
                          item.coverUrl[0],
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ) : Image.asset('assets/img/no-image.jpg'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 6, top: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 14
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed(Routes.detail, arguments: item);
                },
              );
              
              
              // FSuper(
              //   child1: Text(controller.eventList[index].title),
              //   width: 220.0 * (Random().nextDouble() * 0.5 + 0.5),
              //   height: 5.0,
              //   margin: EdgeInsets.only(top: index == 0 ? 0.0 : 12.0),
              //   shadowBlur: 5.0,
              //   shadowOffset: Offset(2.0, 2.0),
              // );
            }
          )
        ),
      )
    );
  }
}