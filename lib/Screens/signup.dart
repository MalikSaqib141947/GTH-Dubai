import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  static const String id = "Singin";
  Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String _country;
  String _accountType;
  @override
  Widget build(BuildContext context) {
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
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
              padding: EdgeInsets.only(left: 10, right: 10),
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
                          "Create Account",
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
                        placeholder: 'First Name',
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        placeholder: 'Last Name',
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: kLightGreyColor,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                          ),
                        ),
                        child: DropdownButton(
                          hint: _country == null
                              ? Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Set Location',
                                    style: TextStyle(
                                        color: kRedColor, fontSize: 16),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    _country,
                                    style: TextStyle(
                                        color: kRedColor, fontSize: 16),
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: kRedColor),
                          items: ['Dubai', 'Nigeria'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _country = val;
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: kLightGreyColor,
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                          ),
                        ),
                        child: DropdownButton(
                          hint: _accountType == null
                              ? Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Account Type',
                                    style: TextStyle(
                                        color: kRedColor, fontSize: 16),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    _accountType,
                                    style: TextStyle(
                                        color: kRedColor, fontSize: 16),
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: kRedColor),
                          items: ['Manager', 'Broker', 'Sales Person'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _accountType = val;
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          placeholder: 'Your Email', onChanged: (value) {}),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        placeholder: 'Your Password',
                        isPassword: true,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        placeholder: 'Confirm Password',
                        isPassword: true,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password must be at least 8 characters and include a special character and number",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: FlatButton(
                              child: Text("Sign Up"),
                              color: kOrangeColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 38, right: 38, top: 15, bottom: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () async {},
                            ),
                          ),
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
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (Login())));
                  },
                  textColor: Colors.white,
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  // TODO: Add functionality
                },
              ),
            ),
          ],
        ),
      ))),
    );
  }
}
