import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/apiservice/ApiService.dart';
import 'package:weather/models/weather_model.dart';

final weatherprovider = FutureProvider<Weathermodel>((ref) {
  return Apiservice().getweather(); //provider with model class
});
