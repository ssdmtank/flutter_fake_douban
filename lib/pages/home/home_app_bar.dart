import 'package:flutter/material.dart';
import 'package:flutter_fake_douban/router.dart';
import 'package:flutter_fake_douban/util/screen_utils.dart';

const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 42.0;

class HomeTabBar extends StatefulWidget implements PreferredSizeWidget {
  final TabBar tabBar;
  final double translate;

  HomeTabBar({Key key, this.tabBar, this.translate}) : super(key: key);

  @override
  _HomeTabBarState createState() => _HomeTabBarState();

  @override
  Size get preferredSize {
    for (Widget item in tabBar.tabs) {
      if (item is Tab) {
        final Tab tab = item;
        if (tab.text != null && tab.icon != null) {
          return Size.fromHeight(
              _kTextAndIconTabHeight + tabBar.indicatorWeight);
        }
      }
      return Size.fromHeight(_kTabHeight + tabBar.indicatorWeight);
    }
  }
}

class _HomeTabBarState extends State<HomeTabBar> {
  double get allHeight => widget.preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: getTop(widget.translate),
          left: 15.0,
          right: ScreenUtils.screenW(context) * 0.75 - 10.0,
          child: getOpacityWidget(
            Container(
              padding: const EdgeInsets.only(
                  top: 3.0, bottom: 3.0, right: 10.0, left: 5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(245, 236, 236, 236),
                borderRadius: BorderRadius.all(Radius.circular(17.0)),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: const Color.fromARGB(255, 128, 128, 129),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Align(
                        alignment: Alignment(1.0, 0.0),
                        child: Text(
                          '搜索',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 192, 192, 192),
                          ),
                        ),
                      ),
                      onTap: () {
                        Router.push(context, Router.searchPage, '搜索流浪地球试一试');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 3,
                          child: widget.tabBar,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  double getTop(double translate) {
    return Tween<double>(begin: allHeight, end: 0.0)
        .transform(widget.translate);
  }

  ////获取透明组件
  Widget getOpacityWidget(Widget child) {
    //非透明
    if (widget.translate == 1) {
      return child;
    }
    return Opacity(
      opacity: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn)
          .transform(widget.translate),
      child: child,
    );
  }
}
