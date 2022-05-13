import 'package:arriva_dart/arriva_dart.dart';
import 'package:arrivapp/departures/departures.screen.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StationPicker extends StatefulWidget {
  const StationPicker({Key? key}) : super(key: key);

  @override
  State<StationPicker> createState() => _StationPickerState();
}

class _StationPickerState extends State<StationPicker> {
  List<Station> _stations = [];
  DateTime _date = DateTime.now();

  final _fromController = DropdownEditingController<String>();
  final _toController = DropdownEditingController<String>();

  void _handleSearch() {
    Navigator.pushNamed(
      context,
      DeparturesScreen.routeName,
      arguments: DeparturesScreenArgs(
        start: _stations.firstWhere((s) => s.name == _fromController.value),
        end: _stations.firstWhere((s) => s.name == _toController.value),
        date: _date,
      ),
    );
  }

  void _handleDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((d) {
      if (d != null) setState(() => _date = d);
    });
  }

  @override
  void initState() {
    Arriva().getStations().then((s) => setState(() => _stations = s));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextDropdownFormField(
          decoration: const InputDecoration(label: Text('From')),
          options: _stations.map((e) => e.name).toList(),
          controller: _fromController,
          dropdownHeight: 512.0,
        ),
        const SizedBox(height: 16.0),
        TextDropdownFormField(
          decoration: const InputDecoration(label: Text('To')),
          options: _stations.map((e) => e.name).toList(),
          controller: _toController,
          dropdownHeight: 512.0,
        ),
        const SizedBox(height: 16.0),
        OutlinedButton(
          onPressed: _handleDatePicker,
          child: Text(DateFormat('d. M. y').format(_date)),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _handleSearch,
          child: const Text('Search'),
        ),
      ],
    );
  }
}
