import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/login_checker.dart';
import 'package:fiverrproject1/Screens/requests.dart';
import 'package:fiverrproject1/Screens/signup.dart';
import 'package:fiverrproject1/Screens/drawer.dart';
import 'package:fiverrproject1/Screens/user.dart';

import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> _defaultRoute = {
    Login.id: (context) => Login(),
    Signin.id: (context) => Signin(),
    DrawerMenu.id: (context) => DrawerMenu(),
    Requests.id: (context) => Requests(),
    Users.id: (context) => Users(),
    LoginChecker.id: (context) => LoginChecker(),
  };

  static Map<String, WidgetBuilder> get ROUTE => _defaultRoute;
}
