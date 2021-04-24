import 'package:fiverrproject1/Screens/drawer.dart';

import 'package:flutter/material.dart';
import 'package:fiverrproject1/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: DrawerMenu.id,
      routes: Routes.ROUTE,
    );
  }
}
