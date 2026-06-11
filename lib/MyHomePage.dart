import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/customWidget/wguage.dart';
import 'package:weather/customWidget/windwidget.dart';
import 'dart:math';

import 'providers/providers.dart';

class Myhomepage extends ConsumerWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherprovider);
    print("======================= Maths ===========================");
    print(pi);
    print(sin(30));
    print("======================= Maths ===========================");

    return Scaffold(
      backgroundColor: Color.fromRGBO(12, 12, 83, 1),
      appBar: AppBar(
        title: Center(child: Text("Weather")),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/clouds.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: RefreshIndicator(
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
                //final temp = value.main?.temp ?? 0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 15,
                                sigmaY: 15,
                              ), // Frost effect
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: BoxDecoration(
                                  // White with very low opacity
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(
                                      0.2,
                                    ), // The "edge" of the glass
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: wguage(), // Your custom gauge widget
                                ),
                              ),
                            ),
                          ),
                          //-----first card ends--------
                          Windwidget(),
                          //---secound card ends--------
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
