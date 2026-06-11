import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:weather/providers/providers.dart';

class Windwidget extends ConsumerWidget {
  const Windwidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherprovider);

    return weatherAsync.when(
      data: (weather) {
        final maxtemp = weather.main?.tempMax?.toDouble() ?? 0.0;
        final mintemp = weather.main?.tempMin?.toDouble() ?? 0.0;

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SfRadialGauge(
                    title: const GaugeTitle(text: 'Current Temp'),
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 50,
                        pointers: <GaugePointer>[NeedlePointer(value: maxtemp)],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SfRadialGauge(
                    title: const GaugeTitle(text: 'Min'),
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 50,
                        pointers: <GaugePointer>[NeedlePointer(value: mintemp)],
                      ),
                    ],
                  ),
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
