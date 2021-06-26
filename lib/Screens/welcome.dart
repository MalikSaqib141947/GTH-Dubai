import 'package:fiverrproject1/utilities/constants.dart';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LandingScreen extends StatelessWidget {
  static const String id = 'landing_screen';

  void loadPage(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRedColor,
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffc0012a), Color(0xffed5f5f)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    Spacer(),
                    Text(
                      'Welcome!',
                      style: kTitleTextStyle.copyWith(
                          color: Colors.white, fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Hero(
                        tag: 'logo',
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 95,
                          backgroundImage: AssetImage(
                              'assets/images/GTH-DUBAI-LOGO color (3).png'),
                        )),
                    Spacer(),
                    Spacer(),
                    SizedBox(
                      height: 24.0,
                    ),
                    SizedBox(
                        height: 45,
                        child: RaisedButton(
                            color: Color(0xFF2F7DBF),
                            textColor: Colors.white,
                            child: Text("Sign In"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => (Login())));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(30.0)))),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 45,
                        child: RaisedButton(
                            //color: kSelectedIconColour,
                            //textColor: Colors.white,
                            child: Text("Sign Up"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => (Signin())));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(30.0)))),
                  ],
                ),
              ))),
    );
  }
}
