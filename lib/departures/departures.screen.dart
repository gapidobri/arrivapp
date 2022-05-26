import 'package:arriva_dart/arriva_dart.dart';
import 'package:arrivapp/departures/widgets/departure_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeparturesScreen extends StatelessWidget {
  static const routeName = '/departures';

  const DeparturesScreen({super.key});

  void _handleSwap(BuildContext context, DeparturesScreenArgs args) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: args.copyWith(start: args.end, end: args.start),
    );
  }

  void _handleToday(BuildContext context, DeparturesScreenArgs args) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: args.copyWith(date: DateTime.now()),
    );
  }

  void _handleNextDay(BuildContext context, DeparturesScreenArgs args) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: args.copyWith(
        date: args.date.add(const Duration(days: 1)),
      ),
    );
  }

  void _handlePreviousDay(BuildContext context, DeparturesScreenArgs args) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: args.copyWith(
        date: args.date.subtract(const Duration(days: 1)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DeparturesScreenArgs;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => _handleSwap(context, args),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    args.start.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_rounded),
                Flexible(
                  child: Text(
                    args.end.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              DateFormat('d. M. y').format(args.date),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: DepartureList(args: args),
      ),
      bottomNavigationBar: Row(
        children: [
          const SizedBox(width: 16.0),
          IconButton(
            onPressed: () => _handlePreviousDay(context, args),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => _handleToday(context, args),
            icon: const Icon(Icons.today),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => _handleNextDay(context, args),
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          const SizedBox(width: 16.0),
        ],
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

  DeparturesScreenArgs copyWith({Station? start, Station? end, DateTime? date}) => DeparturesScreenArgs(
        start: start ?? this.start,
        end: end ?? this.end,
        date: date ?? this.date,
      );
}
