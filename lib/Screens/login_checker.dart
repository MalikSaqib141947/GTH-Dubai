import 'package:fiverrproject1/Screens/loader.dart';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fiverrproject1/Screens/drawer.dart';

class LoginChecker extends StatefulWidget {
  static const String id = "LoginChecker";
  LoginChecker({Key key}) : super(key: key);

  @override
  _LoginCheckerState createState() => _LoginCheckerState();
}

@override
class _LoginCheckerState extends State<LoginChecker> {
  bool isLoading = false;
  void goToIntialScreen() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();

    bool logedin = await sharedpref.getBool("loggedin");
    if (logedin == null || logedin == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => (LandingScreen())));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => (DrawerMenu())));
    }
  }

  @override
  Widget build(BuildContext context) {
    this.setState(() {
      isLoading = true;
      goToIntialScreen();
    });
    return isLoading ? Loader() : Scaffold();
  }
}
