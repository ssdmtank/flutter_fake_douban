import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  var _tabs = ['动态','推荐'];

  DefaultTabController getWidget() {
      return DefaultTabController(
        initialIndex: 1,
        length: _tabs.length,
        child: NestedScrollView(headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
          return <Widget>[
            SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: null,
            )
          ];
        }, body: null),
      );

  }

}