import 'package:arriva_dart/arriva_dart.dart';
import 'package:arrivapp/departures/departures.screen.dart';
import 'package:arrivapp/utils.dart';
import 'package:flutter/material.dart';

class DepartureCard extends StatelessWidget {
  final Departure departure;

  final DeparturesScreenArgs args;

  const DepartureCard({
    super.key,
    required this.departure,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    final past = departure.departureTime != null && toDateTime(departure.departureTime!, args.date).isBefore(DateTime.now());
    final textColor = past ? Colors.grey : null;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Spacer(),
            Column(
              children: [
                Text(
                  args.start.name,
                  style: TextStyle(color: textColor),
                ),
                Text(
                  departure.departureTime?.format(context) ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor),
                ),
              ],
            ),
            const Spacer(),
            Text(
              departure.travelTime.toString() + ' min',
              style: TextStyle(color: textColor),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  args.end.name,
                  style: TextStyle(color: textColor),
                ),
                Text(
                  departure.arrivalTime?.format(context) ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
