import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { investor, owner }

class Requests extends StatefulWidget {
  static const String id = 'Requests';
  Requests({Key key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  String _country;
  String _propertyType;
  String _propertyStatus;
  String _nationality;
  String _location;
  String _searchStatus;
  int _radioValue = 0;
  bool _isInvestor = true;
  bool _isOwner = false;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _isInvestor = true;
          _isOwner = false;

          break;
        case 1:
          _isInvestor = false;
          _isOwner = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Requests"),
                backgroundColor: kRedColor,
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text("Request List"),
                    ),
                    Tab(
                      child: Text("New Request"),
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
                          hint: _searchStatus == null
                              ? Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Nationality',
                                    style: TextStyle(
                                        color: kRedColor, fontSize: 16),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    _searchStatus,
                                    style: TextStyle(
                                        color: kRedColor, fontSize: 16),
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: kRedColor),
                          items: ['Search A', 'Search B'].map(
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
                                _searchStatus = val;
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
                  SingleChildScrollView(
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
                                      "Client Imformation",
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
                                  CustomTextField(
                                    placeholder: 'WhatsApp',
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Email',
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Address',
                                    minLines: 3,
                                    maxLines: 3,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0)),
                                      ),
                                    ),
                                    child: DropdownButton(
                                      hint: _nationality == null
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Nationality',
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                _nationality,
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
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
                                            _nationality = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      new Row(children: [
                                        new Radio(
                                          activeColor: kRedColor,
                                          value: 0,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        new Text(
                                          'Investor',
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
                                          'Owner',
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        )
                                      ]),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Client Requirements",
                                      style: TextStyle(
                                        color: kOrangeColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0)),
                                      ),
                                    ),
                                    child: DropdownButton(
                                      hint: _propertyType == null
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Property Type',
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                _propertyType,
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
                                              ),
                                            ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: kRedColor),
                                      items: ['Type A', 'Type B', 'Type C'].map(
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
                                            _propertyType = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0)),
                                      ),
                                    ),
                                    child: DropdownButton(
                                      hint: _propertyStatus == null
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Property Status',
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                _propertyStatus,
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
                                              ),
                                            ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: kRedColor),
                                      items: ['Status A', 'Status B'].map(
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
                                            _propertyStatus = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                      placeholder: 'No of beds',
                                      onChanged: (value) {}),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Size',
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Area',
                                    onChanged: (value) {},
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0)),
                                      ),
                                    ),
                                    child: DropdownButton(
                                      hint: _location == null
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Location',
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                _location,
                                                style: TextStyle(
                                                    color: kRedColor,
                                                    fontSize: 16),
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
                                            _location = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        child: FlatButton(
                                          child: Text("Submit"),
                                          color: kOrangeColor,
                                          textColor: Colors.white,
                                          padding: EdgeInsets.only(
                                              left: 38,
                                              right: 38,
                                              top: 15,
                                              bottom: 15),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
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
                      ],
                    ),
                  )),
                ],
              ),
            )));
  }
}
