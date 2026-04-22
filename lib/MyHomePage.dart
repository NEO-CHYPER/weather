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
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud, color: Colors.blue),
                    SizedBox(width: 15),
                    Text("Live Data Here"),
                    SizedBox(height: 10),
                    Consumer(
                      builder: (context, ref, child) {
                        return data.when(
                          data:
                              (value) => Text(
                                "Temp => ${value.main?.temp.toString() ?? 0}",
                                style: TextStyle(fontSize: 40),
                                // "Temp => $Weathermodel.fromjson(value).main.temp.toString())",
                              ),
                          error: (e, _) => Text("Error> $e"),
                          loading: () => CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
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
