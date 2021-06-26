//creating a library
library dth.auth;

//importing the required packages
import 'dart:convert';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  var id;
  String title;
  String firstName;
  String lastName;
  String email;
  String role;
  String locationName;
  bool isVerified;
  String jwtToken;
}

//creating the singleton object to access the user's data accross the screens
Auth currentAuth = Auth.getInstance();

//The Auth class
class Auth {
  //The data variables
  Dio dio = new Dio();
  static Auth _instance;
  bool isLoggedIn = false;

  //the private constructor
  Auth._() {}
  User userProfile = new User();

  //static method to get the singleton object
  static Auth getInstance() {
    if (_instance == null) {
      _instance = new Auth._();
    }
    return _instance;
  }

  //Methods

  //Login with a local account
  loginWithLocalAccount(context, email, password) async {
    var params = {
      "email": email,
      "password": password,
    };

    //calling the API
    var response = await http.post(
        'http://gthmobile-001-site1.etempurl.com/Accounts/authenticate',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params));

    //setting the values of the current user object
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      userProfile.title = data['title'];
      userProfile.firstName = data['firstName'];
      userProfile.lastName = data['lastName'];
      userProfile.email = data['email'];
      userProfile.role = data['role'];
      userProfile.locationName = data['location']['name'];
      userProfile.isVerified = data['isVerified'];
      userProfile.jwtToken = data['jwtToken'];
      userProfile.id = data['id'];
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('firstname', userProfile.firstName);
    await sharedPreferences.setString('lastname', userProfile.lastName);
    await sharedPreferences.setString('email', userProfile.email);
    await sharedPreferences.setString('role', userProfile.role);
    await sharedPreferences.setString('title', userProfile.title);
    await sharedPreferences.setString('locationName', userProfile.locationName);
    await sharedPreferences.setBool('isVerified', userProfile.isVerified);
    await sharedPreferences.setString('jwtToken', userProfile.jwtToken);
    await sharedPreferences.setInt('id', userProfile.id);

    //returning the response
    return response;
  }

  //Register a new user
  register(title, firstName, lastName, email, password, confirmPassword,
      acceptTerms, isBroker, isManager, isSalesPerson, locationId) async {
    var params = {
      "title": title,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "acceptTerms": acceptTerms,
      "isBroker": isBroker,
      "isManager": isManager,
      "isSalesPerson": isSalesPerson,
      "locationId": locationId
    };
    //calling the API
    return await http.post(
        'http://gthmobile-001-site1.etempurl.com/Accounts/register',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params));
  }

  //Reset Password
  resetPassword(password, confirmPassword) async {
    var params = {
      "token": userProfile.jwtToken,
      "password": password,
      "confirmPassword": confirmPassword
    };
    //calling the API
    return await http.post(
        'http://gthmobile-001-site1.etempurl.com/Accounts/reset-password',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params));
  }

  //getting all locations
  getLocations() async {
    try {
      return await http.get('http://gthmobile-001-site1.etempurl.com/Location');
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting all the account roles
  getRoles() async {
    try {
      return await http
          .get('http://gthmobile-001-site1.etempurl.com/Accounts/roles');
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting users of a specific role
  getUsers(role) async {
    try {
      var token = userProfile.jwtToken;
      SharedPreferences sharedpref = await SharedPreferences.getInstance();

      String tokenn = await sharedpref.getString("jwtToken");

      if (role == "All Users") {
        return await http.get(
            'http://gthmobile-001-site1.etempurl.com/Accounts',
            headers: {'Authorization': 'Bearer ${tokenn}'});
      } else
        return await http.get(
            'http://gthmobile-001-site1.etempurl.com/Accounts?role=${role}',
            headers: {'Authorization': 'Bearer ${tokenn}'});
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting unapproved users
  getPendingUsers() async {
    try {
      var token = userProfile.jwtToken;
      return await http.get(
          'http://gthmobile-001-site1.etempurl.com/Accounts/unapproved',
          headers: {'Authorization': 'Bearer ${token}'});
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting nationalities
  getNationalities() async {
    try {
      var token = userProfile.jwtToken;
      return await http.get(
          'http://gthmobile-001-site1.etempurl.com/Nationalities',
          headers: {'Authorization': 'Bearer ${token}'});
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting property types
  getPropertyTypes() async {
    try {
      var token = userProfile.jwtToken;
      return await http.get(
          'http://gthmobile-001-site1.etempurl.com/PropertyTypes',
          headers: {'Authorization': 'Bearer ${token}'});
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting property statuses
  getPropertyStatuses() async {
    try {
      var token = userProfile.jwtToken;
      return await http.get(
          'http://gthmobile-001-site1.etempurl.com/PropertyStatus',
          headers: {'Authorization': 'Bearer ${token}'});
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting request statuses
  getRequestStatuses() async {
    try {
      var token = userProfile.jwtToken;
      return await http.get(
          'http://gthmobile-001-site1.etempurl.com/RequestStatus',
          headers: {'Authorization': 'Bearer ${token}'});
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //getting request statuses
  approveAccount(email) async {
    try {
      var token = userProfile.jwtToken;
      var params = {"email": email};
      print(email);
      return await http.post(
          'http://gthmobile-001-site1.etempurl.com/Accounts/approve-account',
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}'
          },
          body: jsonEncode(params));
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //posting a request
  postRequest(
      name,
      mobile,
      whatsapp,
      email,
      address,
      isInvestor,
      propertyTypeId,
      propertyStatusId,
      noOfBeds,
      size,
      area,
      locationId) async {
    var token = userProfile.jwtToken;
    var params = {
      "id": 0,
      "name": name,
      "mobile": mobile,
      "whatsapp": whatsapp,
      "email": email,
      "address": address,
      "isInvestor": isInvestor,
      "propertyTypeId": propertyTypeId,
      "propertyStatusId": propertyStatusId,
      "noOfBeds": noOfBeds,
      "size": size,
      "area": area,
      "locationId": locationId
    };

    //calling the API
    return await http.post('http://gthmobile-001-site1.etempurl.com/Requests',
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}'
        },
        body: jsonEncode(params));
  }

  //getting requests
  getRequests(statusId) async {
    try {
      var token = userProfile.jwtToken;
      if (statusId == -1) {
        return await http.get(
            'http://gthmobile-001-site1.etempurl.com/Requests',
            headers: {'Authorization': 'Bearer ${token}'});
      } else {
        return await http.get(
            'http://gthmobile-001-site1.etempurl.com/Requests?status=${statusId}',
            headers: {'Authorization': 'Bearer ${token}'});
      }
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //logging out
  logout(context) async {
    userProfile.jwtToken = null;
    SharedPreferences sharepref = await SharedPreferences.getInstance();
    sharepref.setBool("loggedin", false);
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => (Login())));
  }

  //take action on a request
  takeAction(requestId, statusId) async {
    var params = {"requestId": requestId, "requestStatusId": statusId};
    try {
      var token = userProfile.jwtToken;
      if (statusId != -1) {
        return await http.post(
            'http://gthmobile-001-site1.etempurl.com/Requests/take-action',
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer ${token}'
            },
            body: jsonEncode(params));
      }
    } catch (e) {
      Fluttertoast.showToast(
          //e.response.data['msg'].toString()
          msg: "An error occured, please check your internet connection!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
