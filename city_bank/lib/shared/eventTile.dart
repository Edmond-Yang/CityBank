import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:city_bank/shared/eventModal.dart';
import 'package:flutter/material.dart';

class EventTile extends StatefulWidget {
  final Event event;
  final SuperUser? user;
  final time;
  Function rebuilt;
  EventTile(
      {Key? key,
      required this.event,
      required this.user,
      required this.time,
      required this.rebuilt})
      : super(key: key);

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  var showLoading = false;
  @override
  Widget build(BuildContext context) {
    void showModal() {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return EventModal(
                event: widget.event,
                user: widget.user,
                time: widget.time,
                rebuilt: widget.rebuilt);
          });
    }

    return TextButton(
      onPressed: showModal,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
            child: ListTile(
          leading: Image.asset(
              'images/${widget.event.category.toLowerCase()}.png',
              width: 80),
          title: Text(
            widget.event.details,
            style: TextStyle(fontFamily: 'Nunito', fontSize: 25.0),
          ),
          subtitle: Text(
            text[widget.event.category]![widget.user!.setting.language]!,
            style: TextStyle(fontFamily: 'Nunito', fontSize: 18.0),
          ),
          trailing: Text('\$ ${widget.event.price}'),
        )),
      ),
      style: TextButton.styleFrom(primary: Colors.brown[50]),
    );
  }
}
