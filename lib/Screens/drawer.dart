import 'package:fiverrproject1/Screens/home.dart';
import 'package:fiverrproject1/Screens/login.dart';
import 'package:fiverrproject1/Screens/requests.dart';
import 'package:fiverrproject1/Screens/user.dart';
import 'package:fiverrproject1/utilities/auth.dart' as auth;
import 'package:fiverrproject1/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  static const String id = 'DrawerMenu';
  DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String fName, lName, email, role;
  getUsername() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String firstname = sharedPref.get('firstname');
    String lastname = sharedPref.get('lastname');
    if (firstname == null) return 'Anonymous';

    auth.currentAuth.userProfile.jwtToken =
        await sharedPref.getString("jwtToken");
    return firstname + ' ' + lastname;
  }

  getCredentials() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    fName = sharedPref.get('firstname');
    lName = sharedPref.get('lastname');
    email = sharedPref.get('email');
    role = sharedPref.get('role');

    return fName + ' ' + lName + '\n' + email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        backgroundColor: kRedColor,
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
          FutureBuilder(
            future: getCredentials(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: kRedColor),
                  accountName: Text(fName + ' ' + lName),
                  accountEmail: Text(email),
                );
              } else {
                return Container();
              }
            },
          ),
          ListTile(
            title: Text('User'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => (Users())));
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
            title: Text('Customers'),
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
          ListTile(
            title: Text('Logout'),
            leading: Icon(FontAwesomeIcons.signOutAlt),
            onTap: () {
              auth.currentAuth.logout(context);
            },
          ),
        ]),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getUsername(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Center(
                        child: Text(
                      "Welcome " + snapshot.data + "!",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: CircularProgressIndicator(),
                  );
                }
              },
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
                            cards(context, "Users", Users(),
                                FontAwesomeIcons.user, Color(0xffF5895D)),
                            SizedBox(
                              width: 10,
                            ),
                            cards(context, "Settings", Home(),
                                FontAwesomeIcons.cog, Color(0xff48C1E1))
                          ],
                        ),
                      );
                    else
                      return Container();
                  } else
                    return Container();
                })
          ],
        ),
      ),
    );
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
