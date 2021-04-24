import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  static const String id = 'Users';
  Users({Key key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Users> {
  String _searchrole;

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
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
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
                          hint: _searchrole == null
                              ? Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Filter by Roles',
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
                          items: ['Role A', 'Role B'].map(
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
                                _searchrole = val;
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          children: [
                            GestureDetector(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 8,
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Request 1",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Lorem Ipsum is simply dummy text of the printing ...",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            )),
                            GestureDetector(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 8,
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Request 2",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Lorem Ipsum is simply dummy text of the printing ...",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),

                  //-----------------
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          children: [
                            GestureDetector(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 8,
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Request 1",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Lorem Ipsum is simply dummy text of the printing ...",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            )),
                            GestureDetector(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 8,
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Request 2",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                            "Lorem Ipsum is simply dummy text of the printing ...",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ))
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
