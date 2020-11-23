
/// 分页类
class PageList<T> {
  PageList({this.total, this.list});

  /// 数据总条数
  int total;
  /// 列表数据
  List<T> list;
}