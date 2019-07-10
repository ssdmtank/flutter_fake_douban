import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fake_douban/constant/constant.dart';
import 'package:flutter_fake_douban/pages/container_page.dart';
import 'package:flutter_fake_douban/util/screen_utils.dart';

//App 首页
class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  //是否显示启动广告
  bool showAd = true;
  //底部菜单及页面
  var container = ContainerPage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 控制child是否显示
        // 当offstage为true，控件隐藏； 当offstage为false，显示；
        // 当Offstage不可见的时候，如果child有动画等，需要手动停掉，Offstage并不会停掉动画等操作。
        Offstage(
          child: container,
          offstage: showAd,//广告消失后显示主页
        ),
        // 首页前置页面
        Offstage(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ScreenUtils.screenW(context) / 3,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage(Constant.ASSETS_IMG + 'home.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          '落花有意随流水,流水无心恋落花',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment(1.0, 0.0),
                        child: Container(
                          margin: const EdgeInsets.only(right: 30.0, top: 20.0),
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                          child: CountDownWidget(
                            onCountDownFinishCallBack: (bool value) {
                              if (value) {
                                setState(() {
                                  showAd = false;
                                });
                              }
                            },
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Constant.ASSETS_IMG + 'ic_launcher.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Hi, 豆芽',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            width: ScreenUtils.screenW(context),
            height: ScreenUtils.screenH(context),
          ),
          offstage: !showAd,
        ),
      ],
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final onCountDownFinishCallBack;

  CountDownWidget({Key key, @required this.onCountDownFinishCallBack})
      : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

//定时组件 用于启动前首页倒计时
class _CountDownWidgetState extends State<CountDownWidget> {
  var _seconds = 6;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds',
      style: TextStyle(fontSize: 17.0),
    );
  }

  //启动定时器
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      if (_seconds <= 1) {
        widget.onCountDownFinishCallBack(true);
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }
}
