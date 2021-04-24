//creating a library
library dth.auth;

//importing the required packages
import 'dart:convert';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
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
    return await http.post(
        'http://gthmobile-001-site1.etempurl.com/Accounts/authenticate',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params));
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
          msg: e.response.data['msg'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
