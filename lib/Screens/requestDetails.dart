import 'dart:convert';

import 'package:fiverrproject1/utilities/constants.dart';
import 'package:fiverrproject1/utilities/auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fiverrproject1/Screens/requests.dart' as req;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestDetails extends StatefulWidget {
  static const String id = 'RequestDetails';
  req.Request r;
  List<req.RequestStatus> rslist;
  RequestDetails(this.r, this.rslist);
  @override
  _RequestDetailsState createState() => _RequestDetailsState(r, rslist);
}

class _RequestDetailsState extends State<RequestDetails> {
  bool isLoading = false;
  req.Request request;
  List<req.RequestStatus> rslist;
  var status;
  req.RequestStatus _selectedRequestStatus =
      req.RequestStatus(-1, 'Leave it for now', '45', false);

  var statusColor;
  final _formKey = GlobalKey<FormState>();
  final _formStatus = GlobalKey<FormState>();

  _RequestDetailsState(this.request, this.rslist);

  Future<List<req.RequestStatus>> fetchRequestStatuses() async {
    if (rslist.length == 0) {
      //call the /RequestStatus API end point
      await auth.currentAuth.getRequestStatuses().then((response) {
        if (response.statusCode == 200) {
          //converting the data into json format
          var jsonData = jsonDecode(response.body);
          //going through the array and saving each user in requestStatus list
          for (var reqS in jsonData) {
            req.RequestStatus r = req.RequestStatus(
                reqS['id'], reqS['name'], reqS['code'], reqS['isActive']);
            rslist.add(r);
            print(r.toString());
          }
        } else if (response.statusCode == 401) {
          auth.currentAuth.logout(context);
          Fluttertoast.showToast(
              msg: 'Unauthorized!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    }
    //returning requestStatus list
    return rslist;
  }

  @override
  Widget build(BuildContext context) {
    initState() {}

    String role;
    getCredentials() async {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      role = sharedPref.get('role');
      this.setState(() {
        isLoading = false;
      });
      return role;
    }

    if (request.statusId == 1) {
      status = 'Open';
      statusColor = Colors.blue;
    } else if (request.statusId == 2) {
      status = 'Progress';
      statusColor = Colors.green;
    } else if (request.statusId == 3) {
      status = 'Invalid';
      statusColor = Colors.red;
    } else if (request.statusId == 4) {
      status = 'Qualify';
      statusColor = Colors.orange;
    } else if (request.statusId == 5) {
      status = 'Closed';
      statusColor = Colors.black;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Request Details"),
          backgroundColor: kRedColor,
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                CustomCard(Icons.computer, statusColor, 'Created By', [
                  'Name',
                  'Email',
                  'Role'
                ], [
                  request.createdBy.firstName +
                      ' ' +
                      request.createdBy.lastName,
                  request.createdBy.email,
                  request.createdBy.role
                ], [
                  Icons.person,
                  Icons.email,
                  Icons.person_outline
                ]),
                SizedBox(
                  height: 5,
                ),
                CustomCard(Icons.person, statusColor, 'Client Info', [
                  'Name',
                  'Email',
                  'Address',
                  "Client Type",
                  "Mobile",
                  "WhatsApp"
                ], [
                  request.name,
                  request.email,
                  request.address,
                  request.isInvestor ? "Investor" : "Owner",
                  request.mobile,
                  request.whatsapp
                ], [
                  Icons.person,
                  Icons.email,
                  Icons.pin_drop,
                  Icons.location_city,
                  Icons.phone,
                  FontAwesomeIcons.whatsapp
                ]),
                SizedBox(
                  height: 5,
                ),
                CustomCard(
                    Icons.location_city, statusColor, 'Property Details', [
                  'Type',
                  'Area',
                  'Size',
                  'No of Beds',
                  'Status'
                ], [
                  request.propertyType.name,
                  request.area,
                  request.size,
                  request.noOfBeds.toString(),
                  request.propertyStatus.name
                ], [
                  Icons.location_city,
                  Icons.local_airport,
                  Icons.layers,
                  Icons.threesixty,
                  Icons.location_city,
                ]),
                SizedBox(
                  height: 5,
                ),

                // Text(
                //   'Created By:',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: kRedColor),
                // ),
                // Property(
                //     'Name',
                //     request.createdBy.firstName +
                //         " " +
                //         request.createdBy.lastName),
                // Property('Email', request.createdBy.email),
                // Property('Role', request.createdBy.role),
                SizedBox(
                  height: 20,
                ),
                // Text(
                //   'Property Details:',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: kRedColor),
                // ),
                // Property('Name', request.propertyType.name),
                // Property('Active?', request.propertyType.isActive.toString()),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   'Property Status:',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: kRedColor),
                // ),
                // Property('Name', request.propertyStatus.name),
                // Property('Active?', request.propertyStatus.isActive.toString()),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   'Client Info:',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: kRedColor),
                // ),
                // Property('Name', request.name),
                // Property('Email Address', request.email),
                // Property('Address', request.address),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: getCredentials(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (role == 'Admin' || role == 'Manager')
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                    child: Text("Take Action"),
                                    onPressed: () => {})
                              ],
                            ),
                          );
                        else
                          return Container();
                      } else
                        return Container();
                    })
              ],
            )),
        floatingActionButton: FutureBuilder(
            future: getCredentials(),
            builder: (context, snapshot) {
              rslist[0].name = 'Leave it for now';
              if (snapshot.hasData) {
                if (snapshot.data == 'Admin' || snapshot.data == 'Manager')
                  return FloatingActionButton.extended(
                    label: Text("Take Action"),
                    icon: Icon(Icons.file_upload),
                    elevation: 30,
                    backgroundColor: kRedColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                scrollable: true,
                                content: Column(
                                  //overflow: Overflow.visible,
                                  children: <Widget>[
                                    Text('Change the Status'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child:
                                              DropdownButton<req.RequestStatus>(
                                            key: _formStatus,
                                            //value: '',
                                            hint: new Text(
                                                _selectedRequestStatus.name),
                                            isExpanded: true,
                                            icon: Icon(Icons.arrow_downward),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: TextStyle(),
                                            underline: Container(
                                              height: 2,
                                              color: kRedColor,
                                            ),
                                            onChanged:
                                                (req.RequestStatus newValue) {
                                              setState(() {
                                                _selectedRequestStatus =
                                                    newValue;
                                              });
                                            },
                                            items: rslist.map<
                                                    DropdownMenuItem<
                                                        req.RequestStatus>>(
                                                (req.RequestStatus value) {
                                              return DropdownMenuItem<
                                                  req.RequestStatus>(
                                                value: value,
                                                child: Text(
                                                    value.name.toString(),
                                                    style: TextStyle(
                                                        color: kRedColor)),
                                              );
                                            }).toList(),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    RaisedButton(
                                        color: Color(0xFF2F7DBF),
                                        textColor: Colors.white,
                                        child: Text("Update"),
                                        onPressed: () => {
                                              rslist[0].name = "All Requests",
                                              if (_selectedRequestStatus.id !=
                                                  -1)
                                                auth.currentAuth
                                                    .takeAction(
                                                  request.id,
                                                  _selectedRequestStatus.id,
                                                )
                                                    .then((response) {
                                                  if (response.statusCode ==
                                                      200) {
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg: 'Request Status Updated to ' +
                                                            _selectedRequestStatus
                                                                .name,
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  } else if (response
                                                          .statusCode ==
                                                      401) {
                                                    Fluttertoast.showToast(
                                                        msg: 'Unauthorized!',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: response.statusCode
                                                            .toString(),
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  }
                                                })
                                              else
                                                Navigator.pop(context)
                                            })
                                  ],
                                ),
                              );
                            });
                          });
                    },
                  );
                else
                  return Container();
              } else
                return Container();
            }));
  }
}

Widget Property(icon, iconColor, property, value) {
  return Container(
      child: Column(children: [
    SizedBox(
      height: 3,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: 100,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: iconColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  property,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            )),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 200,
          child: Text(value,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        )
      ],
    ),
  ]));
}

class CustomCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String bottomText;
  List<String> properties;
  List<String> values;
  List<IconData> propertyIcons;

  CustomCard(this.icon, this.color, this.bottomText, this.properties,
      this.values, this.propertyIcons);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: new Stack(
          children: <Widget>[
            Card(
              elevation: 2,
              child: ClipPath(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 25,
                        child: Center(
                            child: Text(
                          bottomText,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )),
                        color: color,
                      ),
                      Container(
                          child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width - 50,
                              padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                              child: Column(children: [
                                SizedBox(
                                  height: 5,
                                ),
                                for (var i = 0; i < properties.length; i++)
                                  Property(propertyIcons[i], color,
                                      properties[i], values[i]),
                                SizedBox(
                                  height: 5,
                                ),
                              ])),
                        ],
                      )),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              // child: Container(
              //   height: 100.0,

              // ),
            ),
            FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Align(
                child: CircleAvatar(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  radius: 20.0,
                  child: Icon(
                    icon,
                  ),
                ),
                alignment: FractionalOffset(1, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
