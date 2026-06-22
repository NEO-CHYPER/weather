import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:weather/providers/providers.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';

class Windwidget extends ConsumerWidget {
  const Windwidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherprovider);

    return weatherAsync.when(
      data: (weather) {
        final currentTemp = weather.main?.temp?.toDouble() ?? 0.0;
        final minTemp = weather.main?.tempMin?.toDouble() ?? 0.0;
        final maxTemp = weather.main?.tempMax?.toDouble() ?? 0.0;
        final windspeed = weather.wind?.speed?.toDouble();
        final winddegree = weather.wind?.deg?.toInt();
        final Windgust = weather.wind?.gust?.toDouble();

        print('wind speed ==> ${windspeed ?? 'null'}');
        //print("wind speed 2 >> $windspeed2");
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SfRadialGauge(
                    enableLoadingAnimation: true,
                    backgroundColor: Colors.transparent,
                    title: const GaugeTitle(
                      text: 'Current Temp',
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 50,
                        interval: 10,
                        showLabels: true,
                        showTicks: true,
                        pointers: <GaugePointer>[
                          NeedlePointer(value: currentTemp),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SfRadialGauge(
                    enableLoadingAnimation: true,
                    backgroundColor: Colors.transparent,
                    title: const GaugeTitle(text: 'Max Temp'),
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 50,
                        interval: 10,
                        pointers: <GaugePointer>[NeedlePointer(value: maxTemp)],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SfRadialGauge(
                    enableLoadingAnimation: true,
                    backgroundColor: Colors.transparent,
                    title: const GaugeTitle(text: 'Min Temp'),
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 50,
                        interval: 10,
                        pointers: <GaugePointer>[NeedlePointer(value: minTemp)],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            WeatherIcon(
              icon: WeatherIcons.named("wind"),
              size: 50,
              style: WeatherIconStyle.line,
              format: WeatherIconFormat.lottie,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Speed',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),

                //WeatherIcon(icon: WeatherIcons.named("wind"), size: 50),
                Text(
                  'Degree',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                //WeatherIcon(icon: WeatherIcons.named("wind"), size: 50),
                Text(
                  'Gust',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  windspeed.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),

                Text(
                  winddegree.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),

                Text(
                  Windgust.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
          ],
        );
      },
      error: (err, stack) => Text('Error: $err'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
