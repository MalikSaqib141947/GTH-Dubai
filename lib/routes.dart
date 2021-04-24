import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/signup.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> _defaultRoute = {
    Login.id: (context) => Login(),
    Signin.id: (context) => Signin()
  };

  static Map<String, WidgetBuilder> get ROUTE => _defaultRoute;
}
