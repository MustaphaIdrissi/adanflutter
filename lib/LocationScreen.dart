import 'dart:math';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter/material.dart';
import 'package:adan/Theme/colorapp.dart' as myColorApp;
import 'positionscream.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? heading = 0;
  double? rrrr = 0;
  PositionsCream positionsCream = PositionsCream();

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColorApp.ColorApp().background2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "${heading!.ceil()}",
              style: TextStyle(
                color: myColorApp.ColorApp().Textcolor2,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  "images/image3.png",
                ),
                positionsCream, // Use the PositionsCream widget directly
                Transform.rotate(
                  angle: (heading!) * (pi / 180) * -1,
                  child: Image.asset(
                    "images/flichecompass.png",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
