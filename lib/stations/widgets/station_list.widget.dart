import 'package:arriva_dart/arriva_dart.dart';
import 'package:flutter/material.dart';

class StationList extends StatefulWidget {
  const StationList({super.key});

  @override
  State<StationList> createState() => _StationListState();
}

class _StationListState extends State<StationList> {
  List<Station> stations = [];

  void fetchStations() {
    Arriva().getStations().then((s) {
      setState(() => stations = s);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(stations[index].name),
      ),
    );
  }
}
