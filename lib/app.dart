import 'package:arrivapp/departures/departures.screen.dart';
import 'package:arrivapp/stations/stations.screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StationsScreen.routeName,
      routes: {
        StationsScreen.routeName: (context) => const StationsScreen(),
        DeparturesScreen.routeName: (context) => const DeparturesScreen(),
      },
    );
  }
}
