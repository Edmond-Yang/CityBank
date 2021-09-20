import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/services/database.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:city_bank/shared/eventTile.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  final SuperUser? user;
  final Map<String, dynamic>? listEvent;
  final date;
  Function rebuilt;
  int? total;
  EventList(
      {Key? key,
      required this.user,
      required this.listEvent,
      required this.date,
      required this.rebuilt})
      : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<Widget> built = [];

  List<Widget> getEvent() {
    if (widget.listEvent != null) {
      int total = 0;
      List<Event> event = [];
      List<Widget> eventWidget = [];
      widget.listEvent!.forEach((key, value) {
        total += eventFromMap(value).price;
        event.add(eventFromMap(value));
      });

      event = BubbleSort(event);
      event.forEach((element) {
        eventWidget.add(EventTile(
            event: element,
            user: widget.user,
            time: widget.date,
            rebuilt: widget.rebuilt));
      });

      widget.total = total;
      return eventWidget;
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

  List<Event> BubbleSort(List<Event> event) {
    bool isFinished = true;
    for (int i = 0; i < event.length; i++) {
      for (int j = event.length - 1; j > 0; j--) {
        if (event[j].isEarly(event[j - 1])) {
          isFinished = false;
          Event temp = event[j];
          event[j] = event[j - 1];
          event[j - 1] = temp;
        }
      }
      if (isFinished)
        break;
      else
        isFinished = true;
    }
    return event;
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
