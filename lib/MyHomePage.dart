// this page is for UI
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/providers.dart';

class Myhomepage extends ConsumerWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(weatherprovider);
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text("Weather"),
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(weatherprovider.future);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return data.when(
                    data:
                        (value) => Text(
                          "${value.name.toString()}",
                          style: TextStyle(
                            fontSize: 40,
                            color: const Color.fromARGB(255, 168, 12, 134),
                          ),
                          // "Temp => $Weathermodel.fromjson(value).main.temp.toString())",
                        ),
                    error: (e, _) => Text("Error> $e"),
                    loading: () => CircularProgressIndicator(),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud, color: Colors.blue),
                  SizedBox(width: 15),
                  Text("Temp => ", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),

                  Consumer(
                    builder: (context, ref, child) {
                      return data.when(
                        data:
                            (value) => Text(
                              "${value.main?.temp.toString() ?? 0}",
                              style: TextStyle(
                                fontSize: 25,
                                color:
                                    (value.main?.temp ?? 0) < 0
                                        ? Colors.blue
                                        : (value.main?.temp ?? 0) > 35
                                        ? Colors.red
                                        : Colors.black,
                              ),
                              // "Temp => $Weathermodel.fromjson(value).main.temp.toString())",
                            ),
                        error: (e, _) => Text("Error> $e"),
                        loading: () => CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ref.invalidate(weatherprovider);
                  print("Refreshing");
                },
                child: Text(
                  "wather",
                  style: TextStyle(color: Colors.blue[100]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
