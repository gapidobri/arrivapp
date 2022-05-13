import 'package:arriva_dart/arriva_dart.dart';
import 'package:arrivapp/departures/departures.screen.dart';
import 'package:flutter/material.dart';

class DepartureList extends StatefulWidget {
  const DepartureList({Key? key, required this.args}) : super(key: key);

  final DeparturesScreenArgs args;

  @override
  State<DepartureList> createState() => _DepartureListState();
}

class _DepartureListState extends State<DepartureList> {
  List<Departure> _departures = [];

  @override
  void initState() {
    Arriva()
        .getDepartures(
          widget.args.start,
          widget.args.end,
          widget.args.date,
        )
        .then((d) => setState(() => _departures = d));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _departures.length,
      itemBuilder: (context, i) {
        final departure = _departures[i];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      departure.departureTime?.format(context) ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      departure.arrivalTime?.format(context) ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text('${departure.distance} km'),
                    Text('${departure.price} €'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
