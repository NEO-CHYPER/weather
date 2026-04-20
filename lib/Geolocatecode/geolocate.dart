import 'dart:async';

import 'package:geolocator/geolocator.dart';

class Geolocate {
  Future<Map<String, double>> GetLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      //desiredAccuracy: LocationAccuracy.high
    );

    print("___________Location Data____________");
    print(position.latitude);
    print(position.longitude);
    print("___________Location Data____________");

    return {'latitude': position.latitude, 'longitude': position.longitude};
  }
}
