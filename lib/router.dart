import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fake_douban/pages/web_view_page.dart';

//https://www.jianshu.com/p/b9d6ec92926f
class Router {
  static const homePage = 'app://';
  static const detailPage = 'app://DetailPage';
  static const playListPage = 'app://VideosPlayPage';
  static const searchPage = 'app://SearchPage';
  static const photoHero = 'app://PhotoHero';
  static const personDetailPage = 'app://PersonDetailPage';

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }

  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      return WebViewPage(
        url,
        params: params,
      );
    } else {
      switch (url) {
        default:
          return null;
      }
    }
    return null;
  }
}
