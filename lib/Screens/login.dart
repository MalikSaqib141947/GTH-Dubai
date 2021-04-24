import 'dart:convert';
import 'package:fiverrproject1/Screens/signup.dart';
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\t\tGTH DUBAI",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 8),
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
                                        //setting the values of the user object in auth
                                        var data = jsonDecode(response.body);
                                        print(response.body);
                                        auth.currentAuth.userProfile.title =
                                            data['title'];
                                        auth.currentAuth.userProfile.firstName =
                                            data['firstName'];
                                        auth.currentAuth.userProfile.lastName =
                                            data['lastName'];
                                        auth.currentAuth.userProfile.email =
                                            data['email'];
                                        auth.currentAuth.userProfile.role =
                                            data['role'];

                                        auth.currentAuth.userProfile
                                                .locationName =
                                            data['location']['name'];
                                        auth.currentAuth.userProfile
                                            .isVerified = data['isVerified'];
                                        auth.currentAuth.userProfile.jwtToken =
                                            data['jwtToken'];

                                        //showing info to user
                                        Fluttertoast.showToast(
                                            msg: 'Authenticated',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        var responseInJson =
                                            jsonDecode(response.body);
                                        print(responseInJson);
                                        var msg;
                                        if (responseInJson['message'] == null)
                                          msg = responseInJson['errors']
                                              .toString();
                                        else
                                          msg = responseInJson['message'];
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
