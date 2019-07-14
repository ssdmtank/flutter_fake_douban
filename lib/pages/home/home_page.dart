import 'package:flutter/material.dart';
import 'package:flutter_fake_douban/bean/subject_entity.dart';
import 'package:flutter_fake_douban/constant/constant.dart';
import 'package:flutter_fake_douban/http/API.dart';
import 'package:flutter_fake_douban/http/mock_request.dart';
import 'dart:math' as math;
import 'package:flutter_fake_douban/widget/search_text_field_widget.dart';

import '../../router.dart';
import 'my_home_tab_bar.dart';

//首页
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}

var _tabs = ['动态', '推荐'];

//计算宽度
//  final double t = (1.0 -
//      (math.max(minExtent, maxExtent - shrinkOffset) - minExtent) /
//          deltaExtent);
//      .clamp(0.0, 1.0);

//  Color color = Color.lerp(Colors.white, Colors.green, t);

DefaultTabController getWidget() {
  return DefaultTabController(
    initialIndex: 1,
    length: _tabs.length,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
              //防止超出
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                //可以跟随页面滚动的appbar
                pinned: true,
                //是否固定在底部
                expandedHeight: 120.0,
                //展开高度
                primary: true,
                //是否预留高度
                titleSpacing: 0.0,
                backgroundColor: Colors.white,
                //可展开区域
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    color: Colors.green,
                    child: SearchTextFieldWidget(
                      hintText: '影视作品中你难忘的离别',
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                      onTab: () {
                        Router.push(context, Router.searchPage, '影视作品中你难忘的离别');
                      },
                    ),
                    alignment: Alignment(0.0, 0.0),
                  ),
                ),
                bottom: TabBar(
                  //TODO homtabbar
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.0,
                  tabs: _tabs
                      .map((String name) => Container(
                            child: Text(
                              name,
                              style: TextStyle(fontSize: 17.0),
                            ),
                            padding:
                                const EdgeInsets.only(bottom: 5.0, top: 5.0),
                          ))
                      .toList(),
                ),
              ))
        ];
      },
      body: TabBarView(
          //TODO
          children: _tabs.map((String name) {
        return Text("123");
      }).toList()),
    ),
  );
}

class SliverContainer extends StatefulWidget {
  final String name;

  SliverContainer({Key key, @required this.name}) : super(key: key);

  @override
  _SliverContainerState createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> {
  List<Subject> list;

  @override
  void initState() {
    super.initState();

    if (list == null || list.isEmpty) {
      if (_tabs[0] == widget.name) {
        requestAPI();
      }
    } else {
      requestAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getContentSliver(context, list);
  }

  void requestAPI() async {
    var _request = MockRequest();
    var result = await _request.get(API.TOP_250);
    var resultsList = result['subjects'];
    list = resultsList.map<Subject>((item) => Subject.fromMap(item)).toList();
    setState(() {});
  }

  getContentSliver(BuildContext context, List<Subject> list) {
    //动态页签
    if (widget.name == _tabs[0]) {
      return _loginContainer(context);
    }

    if (list == null || list.length == 0) {
      return Text("暂无数据");
    }
    //推荐页签
    //TODO
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          key: PageStorageKey<String>(widget.name),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    ((BuildContext context, int index) {
              return getCommonItem(list, index);
            }), childCount: list.length)),
          ],
        );
      }),
    );
  }

  double singleLineImgHeight = 180.0;
  double contentVideoHeight = 350.0;

  //列表的普通单个item
  getCommonItem(List<Subject> items, int index) {
    Subject item = items[index];
    bool showVideo = index == 1 || index == 3;
    return Container();
  }

  _loginContainer(BuildContext context) {
    //TODO
    return Align(
      alignment: Alignment(0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Constant.ASSETS_IMG + 'ic_new_empty_view_defalut.png',
            width: 120.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
            child: Text(
              '登陆后查看关注人动态',
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          GestureDetector(
            child: Container(
              child: Text(
                '去登陆',
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              ),
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
            ),
            onTap: () {
              Router.push(context, Router.searchPage, 'hahhaha');
            },
          ),
        ],
      ),
    );
  }
}
