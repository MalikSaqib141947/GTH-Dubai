import 'dart:convert';

import 'package:fiverrproject1/Widgets/customTextFeild.dart';
import 'package:fiverrproject1/Screens/requestDetails.dart';
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:fiverrproject1/utilities/auth.dart' as auth;
import 'package:fluttertoast/fluttertoast.dart';

class Request {
  var id;
  String name;
  String mobile;
  String whatsapp;
  String email;
  String address;
  bool isInvestor;
  PropertyType propertyType;
  var propertyTypeId;
  PropertyStatus propertyStatus;
  var propertyStatusId;
  var noOfBeds;
  String size;
  String area;
  Location location;
  var locationId;
  RequestStatus status;
  var statusId;
  User statusBy;
  var statusById;
  User createdBy;
  var createdById;
  var requestDateTime;

  Request(
      this.id,
      this.name,
      this.mobile,
      this.whatsapp,
      this.email,
      this.address,
      this.isInvestor,
      this.propertyType,
      this.propertyTypeId,
      this.propertyStatus,
      this.propertyStatusId,
      this.noOfBeds,
      this.size,
      this.area,
      this.location,
      this.locationId,
      this.status,
      this.statusId,
      this.statusBy,
      this.statusById,
      this.createdBy,
      this.createdById,
      this.requestDateTime);
}

enum SingingCharacter { investor, owner }

class Requests extends StatefulWidget {
  static const String id = 'Requests';
  Requests({Key key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class User {
  var id;
  String title;
  String firstName;
  String lastName;
  String email;
  String role;
  String created;
  bool isVerified;

  User(this.id, this.title, this.firstName, this.lastName, this.email,
      this.role, this.created, this.isVerified);
}

class Nationality {
  int id;
  String name;
  String country;
  String code;

  Nationality(this.id, this.name, this.country, this.code);
}

class RequestStatus {
  int id;
  String name;
  String code;
  bool isActive;

  RequestStatus(this.id, this.name, this.code, this.isActive);
}

class PropertyStatus {
  int id;
  String name;
  String code;
  bool isActive;

  PropertyStatus(this.id, this.name, this.code, this.isActive);
}

class PropertyType {
  int id;
  String name;
  String code;
  bool isActive;

  PropertyType(this.id, this.name, this.code, this.isActive);
}

class Location {
  var id;
  String name;
  String code;

  Location(this.id, this.name, this.code);
}

class _RequestsState extends State<Requests> {
  var id = 0;
  String firstName, lastName, mobile, whatsapp, email, address, size, area = '';
  var noOfBeds = 0;
  bool postingRequest = false;
  String _country;
  String _propertyType;
  String _propertyStatus;
  String _nationality;
  Location _selectedlocation = Location(0, 'Location', '0');
  Nationality _selectedNationality =
      Nationality(0, 'Nationality', 'Nation', '0');
  PropertyType _selectedPropertyType =
      PropertyType(0, 'Property Type', '0', false);
  PropertyStatus _selectedPropertyStatus =
      PropertyStatus(0, 'Property Status', '0', false);
  RequestStatus _selectedRequestStatus =
      RequestStatus(-1, 'All Requests', '0', false);
  String _searchStatus;
  int _radioValue = 0;
  bool _isInvestor = true;
  bool _isOwner = false;
  List<Nationality> _nationalitiesList = [];
  List<PropertyType> _propertyTypeList = [];
  List<PropertyStatus> _propertyStatusList = [];
  List<RequestStatus> _requestStatusList = [];
  List<Location> _locationsList = [];
  List<Request> _requestsList = [];
  bool _locationClicked = false;
  bool _nationalityClicked = false;
  bool _propertyTypeClicked = false;
  bool _propertyStatusClicked = false;
  bool _requestStatusClicked = false;
  bool removeFlag = false;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _isInvestor = false;
          _isOwner = true;

          break;
        case 1:
          _isInvestor = true;
          _isOwner = false;
          break;
      }
    });
  }

  Future<List<Nationality>> fetchNationalities() async {
    if (_nationalitiesList.length == 0) {
      //call the /Nationalities API end point
      await auth.currentAuth.getNationalities().then((response) {
        if (response.statusCode == 200) {
          //converting the data into json format
          var jsonData = jsonDecode(response.body);
          //going through the array and saving each user in nationalities list
          for (var nationality in jsonData) {
            Nationality n = Nationality(nationality['id'], nationality['name'],
                nationality['country'], nationality['code']);
            _nationalitiesList.add(n);
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
    //returning nationalities list
    return _nationalitiesList;
  }

  Future<List<PropertyType>> fetchPropertyTypes() async {
    if (_propertyTypeList.length == 0) {
      //call the /PropertyTypes API end point
      await auth.currentAuth.getPropertyTypes().then((response) {
        if (response.statusCode == 200) {
          //converting the data into json format
          var jsonData = jsonDecode(response.body);
          //going through the array and saving each user in propertyType list
          for (var prpT in jsonData) {
            PropertyType pt = PropertyType(
                prpT['id'], prpT['name'], prpT['code'], prpT['isActive']);
            _propertyTypeList.add(pt);
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
    //returning propertyType list
    return _propertyTypeList;
  }

  Future<List<PropertyStatus>> fetchPropertyStatuses() async {
    if (_propertyStatusList.length == 0) {
      //call the /PropertyStatus API end point
      await auth.currentAuth.getPropertyStatuses().then((response) {
        if (response.statusCode == 200) {
          //converting the data into json format
          var jsonData = jsonDecode(response.body);
          //going through the array and saving each user in propertyStatus list
          for (var prpS in jsonData) {
            PropertyStatus ps = PropertyStatus(
                prpS['id'], prpS['name'], prpS['code'], prpS['isActive']);
            _propertyStatusList.add(ps);
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
    //returning propertyStatus list
    return _propertyStatusList;
  }

  Future<List<RequestStatus>> fetchRequestStatuses() async {
    if (_requestStatusList.length == 0) {
      //call the /RequestStatus API end point
      await auth.currentAuth.getRequestStatuses().then((response) {
        if (response.statusCode == 200) {
          //converting the data into json format
          var jsonData = jsonDecode(response.body);
          //going through the array and saving each user in requestStatus list
          if (removeFlag == false)
            _requestStatusList
                .add(RequestStatus(-1, 'All Requests', '0', false));
          for (var reqS in jsonData) {
            RequestStatus r = RequestStatus(
                reqS['id'], reqS['name'], reqS['code'], reqS['isActive']);
            _requestStatusList.add(r);
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

    return _requestStatusList;
  }

  Future<List<Location>> fetchLocations() async {
    if (_locationsList.length == 0) {
      //call the /locations API end point
      await auth.currentAuth.getLocations().then((response) {
        if (response.statusCode == 200) {
          //converting the data into json format
          var jsonData = jsonDecode(response.body);
          //going through the array and saving each location in locations list
          for (var location in jsonData) {
            Location l =
                Location(location['id'], location['name'], location['code']);
            _locationsList.add(l);
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

    //returning locations list
    return _locationsList;
  }

  Future<List<Request>> fetchRequests(status) async {
    _requestsList.clear();
    //call the /Requests API end point
    await auth.currentAuth.getRequests(status).then((response) {
      if (response.statusCode == 200) {
        //converting the data into json format
        var jsonData = jsonDecode(response.body);
        print(response.body.toString());
        //going through the array and saving each user in requests list
        for (var req in jsonData) {
          Location loc;
          if (req['location'] == null)
            loc = null;
          else
            loc = new Location(req['location']['id'], req['location']['name'],
                req['location']['code']);

          RequestStatus reqStatus;
          if (req['requestStatus'] == null)
            reqStatus = null;
          else
            reqStatus = new RequestStatus(
                req['requestStatus']['id'],
                req['requestStatus']['name'],
                req['requestStatus']['code'],
                req['requestStatus']['isActive']);

          Request r = Request(
              req['id'],
              req['name'],
              req['whatsapp'],
              req['mobile'],
              req['email'],
              req['address'],
              req['isInvestor'],
              new PropertyType(
                  req['propertyType']['id'],
                  req['propertyType']['name'],
                  req['propertyType']['code'],
                  req['propertyType']['isActive']),
              req['propertyTypeId'],
              new PropertyStatus(
                  req['propertyStatus']['id'],
                  req['propertyStatus']['name'],
                  req['propertyStatus']['code'],
                  req['propertyStatus']['isActive']),
              req['propertyStatusId'],
              req['noOfBeds'],
              req['size'],
              req['area'],
              loc,
              req['locationId'],
              reqStatus,
              req['statusId'],
              new User(
                  req['statusBy']['id'],
                  req['statusBy']['title'],
                  req['statusBy']['firstName'],
                  req['statusBy']['lastName'],
                  req['statusBy']['email'],
                  req['statusBy']['role'],
                  req['statusBy']['created'],
                  req['statusBy']['isVerified']),
              req['statusById'],
              new User(
                  req['createdBy']['id'],
                  req['createdBy']['title'],
                  req['createdBy']['firstName'],
                  req['createdBy']['lastName'],
                  req['createdBy']['email'],
                  req['createdBy']['role'],
                  req['createdBy']['created'],
                  req['createdBy']['isVerified']),
              req['createdById'],
              req['requestDateTime']);
          _requestsList.add(r);
        }
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Unauthorized!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        auth.currentAuth.logout(context);
      }
    });
    //returning locations list
    return _requestsList;
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
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                          future: fetchRequestStatuses(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var name1;
                              if (_selectedRequestStatus.id == -1) {
                                name1 = "All Requests";
                              } else
                                name1 = _selectedRequestStatus.name;
                              return DropdownButton(
                                hint: _country == null
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          name1,
                                          style: TextStyle(
                                              color: kRedColor, fontSize: 16),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          _selectedRequestStatus.name,
                                          style: TextStyle(
                                              color: kRedColor, fontSize: 16),
                                        ),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: kRedColor),
                                items: _requestStatusList.map(
                                  (val) {
                                    var name;
                                    if (val.id == -1) {
                                      name = "All Requests";
                                    } else
                                      name = val.name;
                                    return DropdownMenuItem<RequestStatus>(
                                      value: val,
                                      child: Text(
                                        name.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _selectedRequestStatus = val;
                                      _requestStatusClicked = true;
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
                      FutureBuilder(
                        future: fetchRequests(_selectedRequestStatus.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                //scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return requestCard(snapshot.data[index],
                                      context, _requestStatusList, this);
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
                                      "Client Information",
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
                                      firstName = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Last Name',
                                    onChanged: (value) {
                                      lastName = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Mobile',
                                    onChanged: (value) {
                                      mobile = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    placeholder: 'WhatsApp',
                                    onChanged: (value) {
                                      whatsapp = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Email',
                                    onChanged: (value) {
                                      email = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Address',
                                    minLines: 3,
                                    maxLines: 3,
                                    onChanged: (value) {
                                      address = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FutureBuilder(
                                      future: fetchNationalities(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return DropdownButton(
                                            hint: _country == null
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _selectedNationality.name,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _selectedNationality.name,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            style: TextStyle(color: kRedColor),
                                            items: _nationalitiesList.map(
                                              (val) {
                                                return DropdownMenuItem<
                                                    Nationality>(
                                                  value: val,
                                                  child: Text(
                                                    val.name.toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  _selectedNationality = val;
                                                  _nationalityClicked = true;
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
                                                child:
                                                    CircularProgressIndicator(
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
                                          'Owner',
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
                                          'Investor',
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
                                  FutureBuilder(
                                      future: fetchPropertyTypes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return DropdownButton(
                                            hint: _country == null
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _selectedPropertyType
                                                          .name,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _selectedPropertyType
                                                          .name,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            style: TextStyle(color: kRedColor),
                                            items: _propertyTypeList.map(
                                              (val) {
                                                return DropdownMenuItem<
                                                    PropertyType>(
                                                  value: val,
                                                  child: Text(
                                                    val.name.toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  _selectedPropertyType = val;
                                                  _propertyTypeClicked = true;
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
                                                child:
                                                    CircularProgressIndicator(
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FutureBuilder(
                                      future: fetchPropertyStatuses(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return DropdownButton(
                                            hint: _country == null
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _selectedPropertyStatus
                                                          .name,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _selectedPropertyStatus
                                                          .name,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            style: TextStyle(color: kRedColor),
                                            items: _propertyStatusList.map(
                                              (val) {
                                                return DropdownMenuItem<
                                                    PropertyStatus>(
                                                  value: val,
                                                  child: Text(
                                                    val.name.toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  _selectedPropertyStatus = val;
                                                  _propertyStatusClicked = true;
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
                                                child:
                                                    CircularProgressIndicator(
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
                                      placeholder: 'No of beds',
                                      onChanged: (value) {
                                        noOfBeds = int.parse(value);
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Size',
                                    onChanged: (value) {
                                      size = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    placeholder: 'Area',
                                    onChanged: (value) {
                                      area = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FutureBuilder(
                                      future: fetchLocations(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return DropdownButton(
                                            hint: _country == null
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _selectedlocation.name,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      _country,
                                                      style: TextStyle(
                                                          color: kRedColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            style: TextStyle(color: kRedColor),
                                            items: _locationsList.map(
                                              (val) {
                                                return DropdownMenuItem<
                                                    Location>(
                                                  value: val,
                                                  child: Text(
                                                    val.name.toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  _selectedlocation = val;
                                                  print(_selectedlocation);
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
                                                child:
                                                    CircularProgressIndicator(
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
                                        child: postingRequest
                                            ? CircularProgressIndicator()
                                            : FlatButton(
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
                                                        BorderRadius.circular(
                                                            5)),
                                                onPressed: () async {
                                                  this.setState(() {
                                                    postingRequest = true;
                                                  });

                                                  auth.currentAuth
                                                      .postRequest(
                                                          lastName,
                                                          mobile,
                                                          whatsapp,
                                                          email,
                                                          address,
                                                          _isInvestor,
                                                          _selectedPropertyType
                                                              .id,
                                                          _selectedPropertyStatus
                                                              .id,
                                                          noOfBeds,
                                                          size,
                                                          area,
                                                          _selectedlocation.id)
                                                      .then((response) async {
                                                    //stopping the spinner/loader
                                                    setState(() {
                                                      postingRequest = false;
                                                    });

                                                    if (response.statusCode ==
                                                        201) {
                                                      //showing info to user
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Request Created!',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              Colors.green,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else if (response
                                                            .statusCode ==
                                                        401) {
                                                      Fluttertoast.showToast(
                                                          msg: 'Unauthorized!',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else if (response
                                                            .statusCode ==
                                                        400) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Bad Request!\nPlease fill all the fields carefully',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else {
                                                      var msg = response.body;
                                                      //The toast message
                                                      Fluttertoast.showToast(
                                                          msg: msg.toString(),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
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
                      ],
                    ),
                  )),
                ],
              ),
            )));
  }
}

class requestCard extends StatelessWidget {
  _RequestsState parent;
  var name;
  var type;
  var status;
  var statusColor;
  Request request;
  BuildContext context;
  List<RequestStatus> requestStatusList;

  requestCard(this.request, this.context, this.requestStatusList, this.parent);

  String timeAgo(String s) {
    DateTime d = DateTime.parse(s);
    Duration diff = DateTime.now().difference(d.add(new Duration(hours: 5)));
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
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

    if (request.isInvestor) {
      type = 'Investor';
    } else {
      type = 'Owner';
    }
    if (request.createdBy == null) {
      name = 'Anonymous';
    } else {
      name = request.createdBy.firstName + ' ' + request.createdBy.lastName;
    }
    return GestureDetector(
        onTap: () {
          final result = Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      (RequestDetails(request, requestStatusList))));
          //this.parent.setState(() {});
        },
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                request.name + '  (${type})',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  color: statusColor,
                                  child: SizedBox(
                                    child: Text(status,
                                        style: TextStyle(color: Colors.white)),
                                  ))
                            ])),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          timeAgo(request.requestDateTime.toString()),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ));
  }
}
