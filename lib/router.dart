import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//https://www.jianshu.com/p/b9d6ec92926f
class Router {
  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }

  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      //TODO
      return null;
    } else {
      switch (url) {
        default:
          return null;
      }
    }
    return null;
  }
}
