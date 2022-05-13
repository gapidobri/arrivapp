import 'package:arriva_dart/arriva_dart.dart';
import 'package:arrivapp/departures/widgets/departure_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeparturesScreen extends StatelessWidget {
  static const routeName = '/departures';

  const DeparturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DeparturesScreenArgs;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    args.start.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_rounded),
                Flexible(
                  child: Text(
                    args.end.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(DateFormat('d. M. y').format(args.date)),
            const SizedBox(height: 8.0),
            Expanded(
              child: DepartureList(args: args),
            ),
          ],
        ),
      ),
    );
  }
}

class DeparturesScreenArgs {
  final Station start, end;
  final DateTime date;

  const DeparturesScreenArgs({
    required this.start,
    required this.end,
    required this.date,
  });
}
