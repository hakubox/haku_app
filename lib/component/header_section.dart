import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String headerTitle;
  final Function onViewMore;

  const HeaderSection({
    Key key,
    this.headerTitle,
    this.onViewMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 16),
          child: Text(headerTitle),
        ),
        onViewMore != null
            ? Container(
                // margin: const EdgeInsets.only(left: 15, top: 2),
                child: FlatButton(
                  onPressed: onViewMore,
                  child: Text('Ver mais ›'),
                ),
              )
            : Container()
      ],
    );
  }
}
