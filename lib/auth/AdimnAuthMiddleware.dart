import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sampleproject/main.dart';

class AdminAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (adminPref.getBool('fetch') != null) {
      return RouteSettings(name: '/adminhomePageSceen');
    }
  }
}
