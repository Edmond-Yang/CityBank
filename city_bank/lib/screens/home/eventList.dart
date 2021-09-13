import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:city_bank/shared/eventTile.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  final SuperUser? user;
  final listEvent;
  EventList({Key? key, required this.user, required this.listEvent})
      : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<Widget> listEvent = [];

  List<Widget> getEvent() {
    if (widget.listEvent != null) {
      List<Widget> event = [];
      widget.listEvent.forEach((key, value) {
        event.add(EventTile(
          event: eventFromMap(value),
          user: widget.user,
        ));
      });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: getEvent(),
    );
  }
}
