
import 'package:haku_app/packages/log/log.dart';
import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';

/// 列表排序组件（未完成）
@deprecated
class ListSort extends StatelessWidget {

  final Map sortConfig;

  const ListSort({Key key, this.sortConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  }[sortConfig['itemA']['sort']]
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
                  }[sortConfig['itemB']['sort']]
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
                  }[sortConfig['itemC']['sort']]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}