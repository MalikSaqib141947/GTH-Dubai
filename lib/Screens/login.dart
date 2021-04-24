import 'package:fiverrproject1/Screens/signup.dart';
import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatelessWidget {
  static const String id = 'Login';
  const Login({Key key}) : super(key: key);

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
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            placeholder: "Password",
                            isPassword: true,
                            onChanged: (value) {},
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
                              FlatButton(
                                child: Text("Login"),
                                color: kRedColor,
                                textColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 38, right: 38, top: 15, bottom: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {},
                              )
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
