import 'package:fiverrproject1/Screens/home.dart';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/requests.dart';
import 'package:fiverrproject1/Screens/user.dart';
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => (Home())));
              },
            ),
            Divider(),
            ListTile(
              title: Text('Requests'),
              leading: Icon(Icons.chat),
              onTap: () {},
            ),
            ListTile(
              title: Text('Customer'),
              leading: Icon(Icons.shield),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Johns!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    children: [
                      cards(context, "Requests", Requests(),
                          FontAwesomeIcons.fileAlt),
                      SizedBox(
                        width: 10,
                      ),
                      cards(context, "Customer", Login(),
                          FontAwesomeIcons.shieldAlt)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Row(
                    children: [
                      cards(context, "User", Users(), FontAwesomeIcons.user),
                      SizedBox(
                        width: 10,
                      ),
                      cards(context, "Settings", Login(), FontAwesomeIcons.cog)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget cards(context, cardName, route, icon) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.height / 4,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            },
            child: Card(
              color: Colors.red[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                          size: 70,
                          color: Colors.grey[700],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cardName,
                        style: TextStyle(fontSize: 20),
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
