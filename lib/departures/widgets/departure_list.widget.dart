import 'package:arriva_dart/arriva_dart.dart';
import 'package:arrivapp/departures/departures.screen.dart';
import 'package:arrivapp/departures/widgets/departure_card.widget.dart';
import 'package:arrivapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DepartureList extends StatefulWidget {
  final DeparturesScreenArgs args;

  const DepartureList({super.key, required this.args});

  @override
  State<DepartureList> createState() => _DepartureListState();
}

class _DepartureListState extends State<DepartureList> {
  final _itemScrollController = ItemScrollController();

  List<Departure> _departures = [];
  bool loading = true;

  @override
  void initState() {
    Arriva()
        .getDepartures(
      widget.args.start,
      widget.args.end,
      widget.args.date,
    )
        .then(
      (d) {
        setState(() {
          _departures = d;
          loading = false;
        });
        if (widget.args.date.day == DateTime.now().day && widget.args.date.month == DateTime.now().month) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final index = _departures.indexWhere(
              (departure) => departure.departureTime != null && toMinutes(departure.departureTime!) > toMinutes(TimeOfDay.now()),
            );
            _itemScrollController.jumpTo(
              index: index == -1 ? 0 : index,
            );
          });
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ScrollablePositionedList.builder(
      itemCount: _departures.length,
      itemScrollController: _itemScrollController,
      itemBuilder: (context, i) => DepartureCard(
        departure: _departures[i],
        args: widget.args,
      ),
    );
  }
}
