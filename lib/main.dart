import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    //设置android状态栏为透明的沉浸。
    //写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        theme: ThemeData(backgroundColor: Colors.white),
        home: Scaffold(
          //控制界面内容 body 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
          resizeToAvoidBottomPadding: false,
          body: Container(
            child: Text("123"),
          ),
        ),
      ),
    );
  }
}

//这个组件用来重新加载整个child Widget的。当我们需要重启APP的时候，可以使用这个方案
class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({Key key, this.child})
      : assert(child != null),
        super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
        context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      UniqueKey key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
