import 'package:flutter/material.dart';
import 'package:flutter_fake_douban/router.dart';
import 'dart:math' as math;
import 'package:flutter_fake_douban/widget/search_text_field_widget.dart';

//tab标题
var titleList = ['电影', '电视', '综艺', '读书', '音乐', '同城'];

List<Widget> tabList;

TabController _tabController;

//书影音内容page
class BookAudioVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookAudioVideoPageState();
  }
}

//SingleTickerProviderStateMixin 实现 Tab 的动画切换效果 (ps 如果有需要多个嵌套动画效果，你可能需要TickerProviderStateMixin)
class _BookAudioVideoPageState extends State<BookAudioVideoPage>
    with SingleTickerProviderStateMixin {
  var tabBar;

  @override
  void initState() {
    super.initState();
    tabBar = HomePageTabBar();
    tabList = getTabList();
    _tabController = TabController(length: tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: DefaultTabController(
              length: titleList.length, child: _getNestedScrollView(tabBar))),
    );
  }

  List<Widget> getTabList() {
    return titleList
        .map((item) => Text(
              '$item',
              style: TextStyle(fontSize: 15),
            ))
        .toList();
  }
}

//滚动组件
Widget _getNestedScrollView(Widget tabBar) {
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      String hintText = '用一部电影来形容你的2018';
      return <Widget>[
        //文本搜索框
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child: SearchTextFieldWidget(
              hintText: hintText,
              onTab: (){
                Router.push(context, Router.searchPage, hintText);
              },
            )
          ),
        ),
        SliverPersistentHeader(
            floating: true, //展开appbar
            pinned: true, //保留appbar
            delegate: _SliverAppBarDelegate(
              maxHeight: 49.0,
              minHeight: 49.0,
              child: Container(
                color: Colors.white,
                child: tabBar,
              )
            ))
      ];
    },
    body: Container(
      //TODO
      child: Text("1"),
    )
  );
}

//观察发现我们想要的最小高度是大于SliverAppBar的。
//同时，整体的形状变化，我们不需要其他的效果，只要保持和外部滚动的大小一致就可以了。
//自定义的_SliverAppBarDelegate ，必须输入最小和最大高度
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.child});

  @override
  double get maxExtent => math.max(minHeight ?? kToolbarHeight, minExtent);

  @override
  double get minExtent => minHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  //如果传递的这几个参数变化了，那就重写创建
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class HomePageTabBar extends StatefulWidget {
  HomePageTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageTabBar();
  }
}

//顶部tabBar切换
class _HomePageTabBar extends State<HomePageTabBar> {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Colors.black;
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedColor = Color.fromARGB(255, 117, 117, 117); //灰色
    unselectStyle = TextStyle(fontSize: 18, color: unselectedColor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TabBar(
        tabs: tabList,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: selectColor, //导航条颜色
        //   TabBarIndicatorSize this.indicatorSize,导航条的长度，（tab：默认等分；label：跟标签长度一致）
        //   indicatorWeight: 2.0,//导航线条粗细
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unselectedColor,
        unselectedLabelStyle: unselectStyle,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}
