
import 'package:flutter/cupertino.dart';
import 'package:flutter_treeview/tree_view.dart';

class ResourceFolderTree extends StatefulWidget {

  /// 绑定数据
  final List<Node> nodes;
  /// 节点主题
  final TreeViewTheme theme;
  /// 是否允许选择父级节点
  final bool canSelectParent;
  /// 树状图控制器
  final TreeViewController treeViewController;
  /// 节点选择函数
  final dynamic Function(Node) onNodeSelected;
  /// 节点展开函数
  final dynamic Function(String, bool) onNodeExpand;

  const ResourceFolderTree({
    Key key,
    this.nodes,
    this.theme,
    this.canSelectParent = false,
    this.treeViewController,
    this.onNodeSelected,
    this.onNodeExpand
  }) : super(key: key);

  @override
  _ResourceFolderTreeState createState() => _ResourceFolderTreeState();
}

class _ResourceFolderTreeState extends State<ResourceFolderTree> {

  TreeViewController _treeViewController;

  @override
  void initState() {
    super.initState();
    _treeViewController = widget.treeViewController.copyWith(
      children: widget.nodes ?? widget.treeViewController.children
    ) ?? TreeViewController(children: widget.nodes);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TreeView(
      shrinkWrap: true,
      controller: _treeViewController,
      physics: const BouncingScrollPhysics(),
      allowParentSelect: widget.canSelectParent,
      supportParentDoubleTap: false,
      onExpansionChanged: widget.onNodeExpand,
      onNodeTap: (key) {
        setState(() {
          _treeViewController = _treeViewController.copyWith(selectedKey: key);
          if (widget.onNodeSelected != null) widget.onNodeSelected(_treeViewController.selectedNode);
        });
      },
      theme: widget.theme
    );
  }
}