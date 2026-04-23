import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/providers.dart';

class Myhomepage extends ConsumerWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherprovider);

    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: const Text("Weather"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(weatherprovider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: weatherAsync.when(
            loading:
                () => const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(child: CircularProgressIndicator()),
                ),

            error:
                (e, _) => Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Text("Error: $e", textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(weatherprovider),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),

            data: (value) {
              final temp = value.main?.temp ?? 0;

              return Column(
                children: [
                  const SizedBox(height: 30),

                  /// 🌆 City Name
                  Text(
                    value.name ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 168, 12, 134),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🌡 Temperature Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud, color: Colors.blue, size: 30),
                      const SizedBox(width: 10),

                      const Text("Temp => ", style: TextStyle(fontSize: 20)),

                      Text(
                        "$temp °C",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color:
                              temp < 0
                                  ? Colors.blue
                                  : temp > 35
                                  ? Colors.red
                                  : Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  /// 🔄 Refresh Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ref.invalidate(weatherprovider);
                    },
                    child: const Text("Refresh Weather"),
                  ),

                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
