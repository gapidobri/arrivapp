import 'package:arriva_dart/arriva_dart.dart';
import 'package:arrivapp/departures/departures.screen.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StationPicker extends StatefulWidget {
  const StationPicker({super.key});

  @override
  State<StationPicker> createState() => _StationPickerState();
}

class _StationPickerState extends State<StationPicker> {
  late final SharedPreferences _sharedPreferences;

  List<Station> _stations = [];
  DateTime _date = DateTime.now();

  final _fromController = DropdownEditingController<String>();
  final _toController = DropdownEditingController<String>();

  List<String> fromList = [], toList = [];

  void _handleHistory(int index) {
    Navigator.pushNamed(
      context,
      DeparturesScreen.routeName,
      arguments: DeparturesScreenArgs(
        start: _stations.firstWhere((s) => s.name == fromList[index]),
        end: _stations.firstWhere((s) => s.name == toList[index]),
        date: _date,
      ),
    );
  }

  void _handleSearch() {
    final start = _stations.firstWhere((s) => s.name == _fromController.value);
    final end = _stations.firstWhere((s) => s.name == _toController.value);

    fromList.insert(0, start.name);
    toList.insert(0, end.name);
    _sharedPreferences.setStringList('from', fromList);
    _sharedPreferences.setStringList('to', toList);

    Navigator.pushNamed(
      context,
      DeparturesScreen.routeName,
      arguments: DeparturesScreenArgs(
        start: start,
        end: end,
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
    Arriva().getStations().then(
          (s) => setState(() {
            _stations = s;
          }),
        );
    SharedPreferences.getInstance().then((instance) {
      _sharedPreferences = instance;
      fromList = _sharedPreferences.getStringList('from') ?? [];
      toList = _sharedPreferences.getStringList('to') ?? [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
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
        const SizedBox(height: 16.0),
        Expanded(
          child: ListView.builder(
            itemCount: fromList.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => _handleHistory(i),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(fromList[i] + ' - ' + toList[i]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
