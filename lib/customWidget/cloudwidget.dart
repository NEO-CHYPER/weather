import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/providers/providers.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';

class Cloudwidget extends ConsumerWidget {
  const Cloudwidget({super.key});

  String getCloudIconName(int cloudPercentage, bool isNight) {
    if (cloudPercentage <= 10) {
      return isNight ? 'clear-night' : 'clear-day';
    } else if (cloudPercentage <= 30) {
      return isNight ? 'partly-cloudy-night' : 'partly-cloudy-day';
    } else if (cloudPercentage <= 70) {
      return 'cloudy';
    } else {
      return 'overcast';
    }
  }

  bool ISnighttime(int timezone) {
    final utcNow = DateTime.now().toUtc();
    final localTime = utcNow.add(Duration(seconds: timezone));
    final hour = localTime.hour;
    return hour < 6 || hour >= 18;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherprovider);
    return weatherAsync.when(
      data: (Weather) {
        final cloudsperccent = Weather.clouds?.all ?? 0;
        final isNight = ISnighttime(0);
        final cloud_name = getCloudIconName(cloudsperccent, isNight);
        return WeatherIcon(
          icon: WeatherIcons.named(cloud_name),
          size: 50,
          style: WeatherIconStyle.line,
          format: WeatherIconFormat.lottie,
        );
      },
      error: (err, stack) => Text('Error: $err'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
