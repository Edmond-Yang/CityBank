import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/services/database.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
            style: TextStyle(fontFamily: 'Nunito', fontSize: 20.0),
          ),
          subtitle: Text(
            text[widget.event.category]![widget.user!.setting.language]!,
            style: TextStyle(fontFamily: 'Nunito', fontSize: 20.0),
          ),
          trailing: Text('\$ ${widget.event.price}'),
        )),
      ),
      style: TextButton.styleFrom(primary: Colors.brown[50]),
    );
  }
}

class EventModal extends StatefulWidget {
  final Event event;
  final SuperUser? user;
  final time;
  Function rebuilt;
  EventModal(
      {Key? key,
      required this.event,
      required this.user,
      required this.time,
      required this.rebuilt})
      : super(key: key);

  @override
  _EventModalState createState() => _EventModalState();
}

class _EventModalState extends State<EventModal> {
  var showLoading = false;
  Future deleteEvent() async {
    var receiver = await DataBaseServices(uid: widget.user!.uid)
        .deleteData(widget.event.enCode(), widget.time);
    print(receiver);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.7,
        minChildSize: 0.7,
        builder: (context, scroller) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(30, 20),
              topRight: Radius.elliptical(30, 20),
            ),
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  controller: scroller,
                  child: showLoading
                      ? Column(
                          children: [
                            SizedBox(height: 190.0),
                            SpinKitThreeBounce(
                              color: Colors.brown[400],
                              size: 33.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                                text['deleting']![
                                    widget.user!.setting.language]!,
                                style: timeStyle.copyWith(
                                    color: Colors.brown[400], fontSize: 40.0)),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    iconSize: 20.0,
                                    padding: EdgeInsets.all(1.0),
                                    splashRadius: 20.0,
                                    icon: Icon(
                                      Icons.close,
                                    ))
                              ],
                            ),
                            Text(
                              text['info']![widget.user!.setting.language]!,
                              style: timeStyle,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Image.asset(
                              'images/${widget.event.category.toLowerCase()}.png',
                              height: 80.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    text['category']![
                                        widget.user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  text[widget.event.category]![
                                      widget.user!.setting.language]!,
                                  style: TextStyle(
                                      fontFamily: 'Nunito', fontSize: 25.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    text['detail']![
                                        widget.user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  widget.event.details,
                                  style: TextStyle(
                                      fontFamily: 'Nunito', fontSize: 25.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    text['time']![
                                        widget.user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  widget.event.time.substring(0, 5),
                                  style: TextStyle(
                                      fontFamily: 'Nunito', fontSize: 25.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    text['price']![
                                        widget.user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  '${widget.event.price}',
                                  style: TextStyle(
                                      fontFamily: 'Nunito', fontSize: 25.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextButton.icon(
                                onPressed: () async {
                                  setState(() {
                                    showLoading = true;
                                  });
                                  await deleteEvent();
                                  await widget.rebuilt();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.brown,
                                ),
                                label: Text(
                                  text['delete']![
                                      widget.user!.setting.language]!,
                                  style: appBarTextStyle.copyWith(
                                      color: Colors.brown, fontSize: 20.0),
                                ),
                                style: TextButton.styleFrom(
                                  primary: Colors.brown[100],
                                ))
                          ],
                        ),
                )),
          );
        });
  }
}
