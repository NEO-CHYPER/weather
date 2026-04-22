// import 'dart:convert';
// import 'package:http/http.dart' as http; <== we dont need both imports if we are using Dio
import 'package:weather/models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:weather/Geolocatecode/geolocate.dart';

class Apiservice {
  // this is old way by using jttpand dart converter
  //
  // Future<Weathermodel> getWeather() async {
  //   final url = Uri.parse(
  //     "https://api.openweathermap.org/data/2.5/weather"
  //     "?lat=28.003352"
  //     "&lon=73.337097"
  //     "&appid=4e5cd589c5afcfa2e5f9e08e166cb22f"
  //     "&units=metric",
  //   );

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);

  //     return Weathermodel.fromjson(data);
  //   } else {
  //     throw Exception("Failed to load data");
  //   }
  // }
  final dio = Dio();

  Future<Weathermodel> getweather() async {
    Map<String, double> data = await Geolocate().getLocation();

    // 2. Access values using the keys (matching your Map keys)
    double? lat = data['latitude'];
    double? lng = data['longitude'];
    final response = await dio.get(
      "https://api.openweathermap.org/data/2.5/weather",
      queryParameters: {
        "lat": lat.toString(),
        "lon": lng.toString(),
        "appid": "4e5cd589c5afcfa2e5f9e08e166cb22f",
        "units": "metric",
      },
    );

    if (response.statusCode == 200) {
      return Weathermodel.fromjson(response.data);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
