import 'package:fiverrproject1/Screens/home.dart';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/requests.dart';
import 'package:fiverrproject1/Screens/user.dart';
import 'package:fiverrproject1/utilities/auth.dart' as auth;
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenu extends StatelessWidget {
  static const String id = 'DrawerMenu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: kRedColor,
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: kRedColor),
              accountName: Text('Roberto Aleydon'),
              accountEmail: Text('aleydon@gmail.com'),
            ),
            ListTile(
              title: Text('User'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => (Users())));
              },
            ),
            Divider(),
            ListTile(
              title: Text('Requests'),
              leading: Icon(Icons.chat),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => (Requests())));
              },
            ),
            ListTile(
              title: Text('Customer'),
              leading: Icon(FontAwesomeIcons.shieldAlt),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => (Home())));
              },
            ),
            Divider(),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => (Home())));
              },
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Center(
                      child: Text(
                    "Welcome " + auth.currentAuth.userProfile.firstName + "!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cards(context, "Requests", Requests(),
                          FontAwesomeIcons.fileAlt, Color(0XffF56564)),
                      SizedBox(
                        width: 10,
                      ),
                      cards(context, "Customers", Home(),
                          FontAwesomeIcons.shieldAlt, Color(0xff7652F3))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cards(context, "Users", Users(), FontAwesomeIcons.user,
                          Color(0xffF5895D)),
                      SizedBox(
                        width: 10,
                      ),
                      cards(context, "Settings", Home(), FontAwesomeIcons.cog,
                          Color(0xff48C1E1))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget cards(context, cardName, route, icon, color) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          height: MediaQuery.of(context).size.height / 4.5,
          width: MediaQuery.of(context).size.height / 5,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            },
            child: Card(
              color: color, //Colors.red[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Icon(
                          icon,
                          size: 60,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cardName,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
