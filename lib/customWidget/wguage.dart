import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather/providers/providers.dart';

class wguage extends ConsumerStatefulWidget {
  const wguage({super.key});

  @override
  ConsumerState<wguage> createState() => _WGaugeState();
}

class _WGaugeState extends ConsumerState<wguage> {
  @override
  Widget build(BuildContext context) {
    final weather = ref.watch(weatherprovider);
    final Place1 = weather.value?.name?.toString();
    final temp = weather.value?.main?.temp?.toDouble() ?? 0.0;

    return SfRadialGauge(
      // title: GaugeTitle(text: "$Place1",textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(8, 55, 62, 0.4))
      title: GaugeTitle(
        text: "$Place1",
        textStyle: TextStyle(color: Colors.greenAccent, fontSize: 20),
      ),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: -50,
          maximum: 50,

          ranges: [
            GaugeRange(
              startValue: -50,
              endValue: 5,
              color: const Color.fromARGB(255, 108, 96, 235),
            ),
            GaugeRange(
              startValue: 5,
              endValue: 35,
              color: const Color.fromARGB(255, 10, 216, 196),
            ),
            GaugeRange(
              startValue: 35,
              endValue: 50,
              color: const Color.fromARGB(255, 219, 67, 56),
            ),
          ],

          pointers: <GaugePointer>[
            NeedlePointer(
              knobStyle: KnobStyle(color: Color.fromRGBO(56, 19, 191, 0.445)),
              needleColor: const Color.fromARGB(97, 68, 137, 255),
              value: temp, // ✅ clean usage
            ),
          ],

          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                "${temp.toStringAsFixed(1)} °C",
                style: const TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
