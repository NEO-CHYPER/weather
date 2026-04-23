import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/apiservice/ApiService.dart';
import 'package:weather/models/weather_model.dart';

// final weatherprovider = FutureProvider<Weathermodel>((ref) {
//   return Apiservice().getweather(); //provider with model class
// });

final weatherprovider = StreamProvider<Weathermodel>((ref) async* {
  while (true) {
    final data = await Apiservice().getweather();
    yield data;

    await Future.delayed(const Duration(seconds: 10)); // refresh every 10 sec
  }
});
