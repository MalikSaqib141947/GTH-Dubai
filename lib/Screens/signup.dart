import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:fiverrproject1/utilities/auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fiverrproject1/Screens/loader.dart';

class Signin extends StatefulWidget {
  static const String id = "Singin";
  Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class Location {
  var id;
  String name;
  String code;

  Location(this.id, this.name, this.code);
}

class _SigninState extends State<Signin> {
  String _country;
  String _accountType;
  String _title = 'string';
  String _firstName;
  String _lastName, _email, _password, _confirmPassword;
  bool _acceptTerms = true;
  bool _isBroker = true;
  bool _isManager = false;
  bool _isSalesPerson = false;
  Location _location = Location(1, 'Dubai', 'dub');
  bool _locationClicked = false;
  int _radioValue = 0;
  List<Location> locations = [];
  bool isLoading = false;

  Future<List<Location>> fetchLocations() async {
    //once the location button is clicked, we dont need to fetch again even if setState is called
    if (!_locationClicked) {
      //call the /locations API end point
      await auth.currentAuth.getLocations().then((locationsArray) {
        //converting the data into json format
        var jsonData = jsonDecode(locationsArray.body);
        //going through the array and saving each location in locations list
        for (var location in jsonData) {
          Location l =
              Location(location['id'], location['name'], location['code']);
          locations.add(l);
        }
      });
    }
    //returning locations list
    return locations;
  }

  //method to handle the radio buttons value change
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _isBroker = true;
          _isManager = false;
          _isSalesPerson = false;
          break;
        case 1:
          _isBroker = false;
          _isManager = true;
          _isSalesPerson = false;
          break;
        case 2:
          _isBroker = false;
          _isManager = false;
          _isSalesPerson = true;
          break;
      }
    });
  }

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
                    top: MediaQuery.of(context).size.height / 15),
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
                          onChanged: (value) {
                            _firstName = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          placeholder: 'Last Name',
                          onChanged: (value) {
                            _lastName = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FutureBuilder(
                            future: fetchLocations(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton(
                                  hint: _country == null
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            _location.name,
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
                                  items: locations.map(
                                    (val) {
                                      return DropdownMenuItem<Location>(
                                        value: val,
                                        child: Text(
                                          val.name.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _location = val;
                                        _locationClicked = true;
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                        strokeWidth: 4,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  )
                                ]));
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            placeholder: 'Your Email',
                            onChanged: (value) {
                              _email = value;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          placeholder: 'Your Password',
                          isPassword: true,
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          placeholder: 'Confirm Password',
                          isPassword: true,
                          onChanged: (value) {
                            _confirmPassword = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Row(children: [
                                  new Radio(
                                    activeColor: kRedColor,
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text(
                                    'Broker',
                                    style: new TextStyle(fontSize: 16.0),
                                  )
                                ]),
                                Row(children: [
                                  new Radio(
                                    activeColor: kRedColor,
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text(
                                    'Manager',
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  )
                                ]),
                                Row(children: [
                                  new Radio(
                                    activeColor: kRedColor,
                                    value: 2,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  new Text(
                                    'Sales Person',
                                    style: new TextStyle(fontSize: 16.0),
                                  )
                                ])
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Password must be at least 6 character long",
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
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  auth.currentAuth
                                      .register(
                                          _title,
                                          _firstName,
                                          _lastName,
                                          _email,
                                          _password,
                                          _confirmPassword,
                                          true,
                                          _isBroker,
                                          _isManager,
                                          _isSalesPerson,
                                          _location.id)
                                      .then((response) async {
                                    //stopping the spinner/loader
                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (response.statusCode == 200) {
                                      //showing info to user
                                      Fluttertoast.showToast(
                                          msg: 'Registration Successful!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      var responseInJson =
                                          jsonDecode(response.body);
                                      var msg;
                                      if (responseInJson['message'] == null)
                                        msg =
                                            responseInJson['errors'].toString();
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
