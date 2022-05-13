import 'package:arrivapp/stations/widgets/station_picker.widget.dart';
import 'package:flutter/material.dart';

class StationsScreen extends StatelessWidget {
  static const routeName = '/stations';

  const StationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: StationPicker(),
        ),
      ),
    );
  }
}
