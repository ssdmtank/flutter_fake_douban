import 'package:flutter/services.dart' show rootBundle;
import 'API.dart';
import 'dart:async';
import 'dart:convert';
//模拟请求数据
class MockRequest {
  Future<dynamic> get(String action, {Map params}) async {
    return MockRequest.mock(action: getJsonName(action), params: params);
  }

  static Future<dynamic> post({String action, Map params}) async {
    return MockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    return json.decode(responseStr);
  }

  Map<String, String> map = {
    API.IN_THEATERS: 'in_theaters',
    API.COMING_SOON: 'coming_soon',
    API.TOP_250: 'top250',
    API.WEEKLY: 'weekly',
    API.REIVIEWS: 'reviews',
  };

  getJsonName(String action) {
    return map[action];
  }
}
