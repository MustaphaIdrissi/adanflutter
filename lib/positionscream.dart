import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionsCream extends StatefulWidget {
  @override
  _PositionsCreamState createState() => _PositionsCreamState();
}

class _PositionsCreamState extends State<PositionsCream> {
  String _locationMessage = "";
  double? qiblaAngle = 0;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        print(_locationMessage);
        qiblaAngle = calculateQiblaAngle(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  double getQiblaAngle() {
    print(qiblaAngle);
    return (qiblaAngle ?? 0) * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: getQiblaAngle(),
      child: Image.asset(
        "images/qibla_10073987.png",
      ),
    );
  }

  double calculateQiblaAngle(double userLatitude, double userLongitude) {
    // Coordinates of the Kaaba in Mecca
    const double kaabaLat = 21.422487;
    const double kaabaLon = 39.826206;

    // Convert latitude and longitude from degrees to radians
    double userLatRad = degreesToRadians(userLatitude);
    double userLonRad = degreesToRadians(userLongitude);
    double kaabaLatRad = degreesToRadians(kaabaLat);
    double kaabaLonRad = degreesToRadians(kaabaLon);

    // Calculate the Qibla angle using spherical trigonometry
    double lonDiff = kaabaLonRad - userLonRad;

    double y = sin(lonDiff);
    double x =
        cos(userLatRad) * tan(kaabaLatRad) - sin(userLatRad) * cos(lonDiff);

    double qiblaRad = atan2(y, x);

    // Convert the angle from radians to degrees
    double qiblaAngle = radiansToDegrees(qiblaRad);

    // Ensure the angle is between 0 and 360
    return (qiblaAngle + 360) % 360;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  double radiansToDegrees(double radians) {
    return radians * (180.0 / pi);
  }
}
