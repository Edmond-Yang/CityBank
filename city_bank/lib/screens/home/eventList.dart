import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:city_bank/shared/eventTile.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  final SuperUser? user;
  final listEvent;
  int? total;
  EventList({Key? key, required this.user, required this.listEvent})
      : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<Widget> built = [];

  List<Widget> getEvent() {
    if (widget.listEvent != null) {
      int total = 0;
      List<Widget> event = [];
      widget.listEvent.forEach((key, value) {
        total += eventFromMap(value).price;
        event.add(EventTile(
          event: eventFromMap(value),
          user: widget.user,
        ));
      });
      widget.total = total;
      return event;
    } else {
      return [
        Container(
          child: Center(
              child: Text(
            text['noData']![widget.user!.setting.language]!,
            style: timeStyle,
          )),
        )
      ];
    }
  }

  Event eventFromMap(Map data) {
    return Event(
        category: data['category'],
        time: data['time'],
        details: data['details'],
        price: data['price']);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    built = getEvent();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: built,
      ),
    );
  }
}
