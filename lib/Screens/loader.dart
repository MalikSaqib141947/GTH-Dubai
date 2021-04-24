import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(1),
        body: SpinKitRing(
          color: Color(0xffc0012a),
          size: 60.0,
        ));
  }
}
