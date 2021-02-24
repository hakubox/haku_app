import 'package:common_utils/common_utils.dart';
import 'package:haku_app/component/index.dart';
import 'package:haku_app/theme/theme.dart';
import 'package:haku_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

/// 评论项
class CommentItem {
  /// 对应Id
  final String id;
  /// 回复Id
  final String parentId;
  /// 用户名
  final String userName;
  /// 用户头像
  final String userHead;
  /// 内容
  final String content;
  /// 创建日期
  final DateTime createDate;
  /// 上传图片
  final List<String> imgList;
  /// 上传文件
  final List<String> fileList;
  /// 内容
  final List<CommentItem> replyList;
  /// 评分
  final int level;
  /// 点赞
  final bool like;

  CommentItem({ 
    this.id,
    this.parentId, 
    this.userName, 
    this.userHead, 
    this.content, 
    this.createDate,
    this.replyList = const [],
    this.imgList = const [],
    this.fileList = const [],
    this.level, 
    this.like 
  });
}

/// 评论组件
class Comment extends StatelessWidget {

  /// 标题
  final String title;
  /// 是否在标题上显示评论总数
  final bool showCommentCount;
  /// 是否绘制所有评论项
  final bool shrinkWrap;
  /// 是否绘制分割线
  final bool hasDivider;
  /// 高度
  final double height;
  /// 评论列表
  final List<CommentItem> commentList;
  /// 点评事件
  final Function(CommentItem comment) onLike;
  /// 回复事件
  final Function(CommentItem comment) onAnswer;
  /// 启用点赞功能
  final openLike;

  const Comment({
    Key key, 
    this.title = '全部评论',
    this.height,
    this.showCommentCount = true,
    this.shrinkWrap = true, 
    this.hasDivider = true,
    this.commentList = const [], 
    this.onLike, 
    this.onAnswer,
    this.openLike = false,
  }) : super(key: key);

  Widget commentBuild(CommentItem comment, [CommentItem parentComment]) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: hasDivider ? Border(
              bottom: BorderSide(
                color: Color(0xFFDDDDDD),
                width: 0.5
              )
            ) : Border(),
          ),
          padding: EdgeInsets.only(
            bottom: hasDivider ? 10 : 6
          ),
          margin: EdgeInsets.only(
            bottom: 12
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              comment.userHead != null ? Img(comment.userHead, width: 36, 
                margin: EdgeInsets.only(
                  right: 10
                )
              ) : Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  right: 10
                ),
                decoration: BoxDecoration(
                  color: currentTheme.primaryColor,
                  shape: BoxShape.circle
                ),
                child: Text(comment.userName.substring(0, 1), style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 40,
                              child: Wrap(
                                spacing: 4,
                                children: [
                                  Text(comment.userName ?? '', 
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  ...(parentComment != null ? [
                                    Container(
                                      height: 26,
                                      alignment: Alignment.center,
                                      child: Icon(LineIcons.caret_right,
                                        size: 16,
                                        color: Color(0xFFCCCCCC),
                                      ),
                                    ),
                                    Text(parentComment.userName, 
                                      style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ] : [])
                                ],
                              )
                            ),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   height: 40,
                            //   child: Slot(badge, Img(badge))
                            // ),
                          ],
                        ),
                        // 点赞功能
                        Wrap(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 40,
                              child: Text('230')
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 4),
                              alignment: Alignment.centerLeft,
                              height: 40,
                              child: Icon(LineIcons.angle_up, size: 18)
                            ),
                          ],
                        ).visible(openLike),
                      ],
                    ),

                    // 内容
                    Container(
                      padding: EdgeInsets.only(top: 0),
                      child: Text(comment.content ?? '',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                    ),

                    // 发表时间、回复等
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        top: 6
                      ),
                      child: Wrap(
                        spacing: 10,
                        children: [
                          comment.createDate != null ? Text(
                            TimelineUtil.formatByDateTime(comment.createDate, locale: 'zh'), 
                            style: TextStyle(
                              color: Color(0xFFBBBBBB),
                              fontSize: 12
                            )
                          ) : SizedBox(),
                          InkWell(
                            child: Text('回复', 
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 12
                              )
                            ),
                            onTap: () {
                              if (onAnswer != null) onAnswer(comment);
                            },
                          ).visible(onAnswer),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        ...comment.replyList.map((childComment) => commentBuild(childComment, comment)).toList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only( bottom: 20 ),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
                children: [
                  TextSpan(text: title),
                  TextSpan(text: showCommentCount ? '（${commentList.length.toString()}）' : ''),
                ]
              ),
            )
          ),
          ListView.builder(
            // TODO: ListView性能优化项
            // itemExtent: 200,
            itemCount: commentList.length,
            shrinkWrap: height != null ? false : shrinkWrap,
            physics: height != null ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return commentBuild(commentList[index]);
            },
          ),
        ],
      )
    );
  }
}