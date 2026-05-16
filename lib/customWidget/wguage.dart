import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/providers/providers.dart';

class wguage extends ConsumerWidget {
  const wguage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherprovider);

    return weatherAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
      data: (weather) {
        final temp = weather.main?.temp?.toDouble() ?? 0.0;
        final cityName = weather.name ?? "Unknown";

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Weather Icon (Matches the cloud/snow in your image)
            const Icon(
              Icons.cloud_queue, // Use WeatherIcons package for better icons
              color: Colors.white,
              size: 60,
            ),
            const SizedBox(height: 10),

            // 2. Temperature Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${temp.toInt()}",
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight:
                        FontWeight.w300, // Light font weight for modern look
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "°C",
                    style: TextStyle(fontSize: 24, color: Colors.white70),
                  ),
                ),
              ],
            ),

            // 3. Location Name (Rotated style like your image)
            Transform.rotate(
              angle: -0.1, // Slight tilt like the image
              child: Text(
                cityName,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.2,
                  color: Colors.white60,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
