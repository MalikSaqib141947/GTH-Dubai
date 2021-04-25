import 'dart:convert';
import 'package:fiverrproject1/Screens/signup.dart';
import 'package:fiverrproject1/Screens/drawer.dart';
import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:fiverrproject1/utilities/auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fiverrproject1/Screens/loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const String id = 'Login';
  _LoginState();
  String _email;
  String _password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Loader();
    else
      return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffc0012a), Color(0xffed5f5f)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 80),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 90,
                        backgroundImage: AssetImage(
                            'assets/images/GTH-DUBAI-LOGO color (3).png'),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\t\tGTH DUBAI",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 15),
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: kOrangeColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              placeholder: 'Email',
                              onChanged: (value) {
                                this._email = value;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              placeholder: "Password",
                              isPassword: true,
                              onChanged: (value) {
                                this._password = value;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: () {},
                                  child: Text("Forgot Password ?"),
                                ),
                                Spacer(),
                                Container(
                                    child: FlatButton(
                                  child: Text("Login"),
                                  color: kRedColor,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.only(
                                      left: 38, right: 38, top: 15, bottom: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    auth.currentAuth
                                        .loginWithLocalAccount(
                                            context, _email, _password)
                                        .then((response) async {
                                      //stopping the spinner/loader
                                      setState(() {
                                        isLoading = false;
                                      });

                                      if (response.statusCode == 200) {
                                        //showing info to user
                                        Fluttertoast.showToast(
                                            msg: 'Authenticated',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        while (Navigator.of(context).canPop()) {
                                          Navigator.of(context).pop();
                                        }
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    (DrawerMenu())));
                                      } else {
                                        var responseInJson =
                                            jsonDecode(response.body);
                                        var msg;
                                        //If there is no message field, there must be some errors to show to the user
                                        if (responseInJson['message'] == null) {
                                          var jsonErrors =
                                              responseInJson['errors'];
                                          if (jsonErrors['Email'] != null)
                                            msg = jsonErrors['Email'][0];
                                          else if (jsonErrors['Password'] !=
                                              null)
                                            msg = jsonErrors['Password'][0];
                                          else
                                            msg = "Authentication Failed!";
                                        }
                                        //otherwise, show the message field
                                        else
                                          msg = responseInJson['message'];
                                        //The toast message
                                        Fluttertoast.showToast(
                                            msg: msg,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    });
                                  },
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (Signin())));
                        },
                        textColor: Colors.white,
                        child: Text("Create Account",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1,
                  ),
                ],
              )),
        )),
      );
  }
}
