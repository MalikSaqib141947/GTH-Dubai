import 'dart:convert';

import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:fiverrproject1/utilities/auth.dart' as auth;
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  static const String id = 'Users';
  Users({Key key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class User {
  String title;
  String firstName;
  String lastName;
  String email;
  String role;
  bool isVerified;

  User(this.title, this.firstName, this.lastName, this.email, this.role,
      this.isVerified);
}

class _RequestsState extends State<Users> {
  List<String> _roleslist = [];
  List<User> _userslist = [];
  List<User> _pendingUsersList = [];
  String _searchrole = 'All Users';

  Future<List<String>> fetchRoles() async {
    _roleslist.clear();
    //call the /roles API end point
    await auth.currentAuth.getRoles().then((rolesArray) {
      _roleslist.add('All Users');
      //converting the data into json format
      var jsonData = jsonDecode(rolesArray.body);
      //going through the array and saving each role in roles list
      for (var role in jsonData) {
        _roleslist.add(role);
      }
    });
    //returning roles list
    return _roleslist;
  }

  Future<List<User>> fetchUsers(role) async {
    _userslist.clear();
    //call the /accounts API end point
    await auth.currentAuth.getUsers(role).then((response) {
      if (response.statusCode == 200) {
        //converting the data into json format
        var jsonData = jsonDecode(response.body);
        //going through the array and saving each user in users list
        for (var user in jsonData) {
          User u = User(user['title'], user['firstName'], user['lastName'],
              user['email'], user['role'], user['isVerified']);
          _userslist.add(u);
          print(u.email);
        }
      } else if (response.statusCode == 401) {}
    });
    //returning users list
    return _userslist;
  }

  Future<List<User>> fetchPendingUsers() async {
    _pendingUsersList.clear();
    //call the /accounts API end point
    await auth.currentAuth.getPendingUsers().then((response) {
      if (response.statusCode == 200) {
        print(response.body.toString());
        //converting the data into json format
        var jsonData = jsonDecode(response.body);
        //going through the array and saving each user in users list
        for (var user in jsonData) {
          User u = User(user['title'], user['firstName'], user['lastName'],
              user['email'], user['role'], user['isVerified']);
          _pendingUsersList.add(u);
        }
      } else if (response.statusCode == 401) {}
    });
    //returning users list
    return _pendingUsersList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Users"),
                backgroundColor: kRedColor,
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text("All Users"),
                    ),
                    Tab(
                      child: Text("Pending User"),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  //-----------------All users Tab
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                          future: fetchRoles(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return DropdownButton(
                                hint: _searchrole == null
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          _searchrole,
                                          style: TextStyle(
                                              color: kRedColor, fontSize: 16),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          _searchrole,
                                          style: TextStyle(
                                              color: kRedColor, fontSize: 16),
                                        ),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: kRedColor),
                                items: _roleslist.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(
                                        val.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _searchrole = val;
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
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: fetchUsers(_searchrole),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      //scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return userCard2(
                                            snapshot.data[index], context);
                                      });
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
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  //-----------------Pending users Tab
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: fetchPendingUsers(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.length == 0) {
                                    return Center(
                                      child: Text('No pending users...'),
                                    );
                                  } else
                                    return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return userCard(this,
                                              snapshot.data[index], context);
                                        });
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
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }
}

//Widget userCard(User user, context) {
class userCard extends StatelessWidget {
  _RequestsState parent;
  User user;

  userCard(this.parent, this.user, context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
      child: Card(
        color: Colors.white,
        elevation: 10,
        child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Text(
                    user.firstName + ' ' + user.lastName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                      child: Text(
                        user.role,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: RaisedButton(
                        color: Color(0xFF2F7DBF),
                        textColor: Colors.white,
                        child: Text("Approve"),
                        onPressed: () => {
                          auth.currentAuth
                              .approveAccount(user.email)
                              .then((response) {
                            if (response.statusCode == 200) {
                              parent.setState(() {});
                              Fluttertoast.showToast(
                                  msg: 'Approved!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Can't Approve",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              auth.currentAuth.logout(context);
                            }
                          }),
                        },
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    ));
  }
}

Widget userCard2(User user, context) {
  return GestureDetector(
      child: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 8,
    child: Card(
      color: Colors.white,
      elevation: 10,
      child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: Text(
                  user.firstName + ' ' + user.lastName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: Text(
                  user.role,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 1,
                ),
              ),
            ],
          )),
    ),
  ));
}
