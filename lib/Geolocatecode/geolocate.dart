// import 'dart:async';

// import 'package:geolocator/geolocator.dart';

// class Geolocate {
//   Future<Map<String, double>> GetLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//       //desiredAccuracy: LocationAccuracy.high
//     );

//     print("___________Location Data____________");
//     print(position.latitude);
//     print(position.longitude);
//     print("___________Location Data____________");

//     return {'latitude': position.latitude, 'longitude': position.longitude};
//   }
// }

import 'dart:async';
import 'package:geolocator/geolocator.dart';

class Geolocate {
  Future<Map<String, double>> getLocation() async {
    // 1️⃣ Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    // 2️⃣ Request if denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // 3️⃣ Handle denied again
    if (permission == LocationPermission.denied) {
      throw Exception("Location permission denied");
    }

    // 4️⃣ Handle permanently denied
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      throw Exception("Permission permanently denied");
    }

    // 5️⃣ Get location (only if allowed)
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print("___________Location Data____________");
    print(position.latitude);
    print(position.longitude);
    print("__________________________________");

    return {'latitude': position.latitude, 'longitude': position.longitude};
  }
}
