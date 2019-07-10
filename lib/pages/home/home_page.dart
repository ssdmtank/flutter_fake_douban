import 'package:flutter/material.dart';
import 'package:flutter_fake_douban/bean/subject_entity.dart';
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
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
                          Router.push(
                              context, Router.searchPage, '影视作品中你难忘的离别');
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

class SliverContainer extends StatefulWidget{

  final String name;

  SliverContainer({Key key,@required this.name}) :super(key: key);

  @override
  _SliverContainerState createState() => _SliverContainerState();

}

class _SliverContainerState extends State<SliverContainer> {

  List<Subject> list;

  @override
  void initState() {
    super.initState();

    if(list == null || list.isEmpty){
      if(_tabs[0] == widget.name){
        requestAPI();
      }

    }else{
      requestAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getContentSliver(context, list);
  }

  void requestAPI() async{
    var _request= MockRequest();
    var result = await _request.get(API.TOP_250);
    var resultsList = result['subjects'];
    list = resultsList.map<Subject>((item)=> Subject.fromMap(item)).toList();
    setState(() {});
  }

  getContentSliver(BuildContext context, List<Subject> list) {
    //动态页签
    if(widget.name == _tabs[0]){
      return _loginContainer(context);
    }

    if(list == null || list.length == 0){
      return Text("暂无数据");
    }
    //推荐页签
    //TODO





  }

  _loginContainer(BuildContext context) {
    //TODO
  }
}