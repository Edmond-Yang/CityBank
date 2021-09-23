import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/screens/home/update.dart';
import 'package:city_bank/services/database.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  var showFix = false;
  var showDeleting = false;
  var showFixing = false;

  Future deleteEvent() async {
    var receiver = await DataBaseServices(uid: widget.user!.uid)
        .deleteData(widget.event.enCode(), widget.time);
    print(receiver);
  }

  Future fixEvent() async {
    var receiver = await DataBaseServices(uid: widget.user!.uid)
        .deleteData(widget.event.enCode(), widget.time);
    print(receiver);
  }

  @override
  Widget build(BuildContext context) {
    return showFix
        ? UpdateModal(
            user: widget.user,
            date: widget.time,
            func: widget.rebuilt,
            isUpdate: false,
            event: widget.event,
          )
        : DraggableScrollableSheet(
            initialChildSize: 0.85,
            maxChildSize: 0.85,
            minChildSize: 0.85,
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
                      child: showDeleting
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
                                        color: Colors.brown[400],
                                        fontSize: 40.0)),
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
                                  style: timeStyle.copyWith(fontSize: 30.0),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Image.asset(
                                  'images/${widget.event.category.toLowerCase()}.png',
                                  height: 120.0,
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton.icon(
                                        onPressed: () async {
                                          setState(() {
                                            showFix = true;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.settings,
                                          color: Colors.green,
                                        ),
                                        label: Text(
                                          text['fix']![
                                              widget.user!.setting.language]!,
                                          style: appBarTextStyle.copyWith(
                                              color: Colors.green,
                                              fontSize: 20.0),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                            primary: Colors.green[100],
                                            side: BorderSide(
                                                color: Colors.green))),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    OutlinedButton.icon(
                                        onPressed: () async {
                                          setState(() {
                                            showDeleting = true;
                                          });
                                          await deleteEvent();
                                          await widget.rebuilt();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        label: Text(
                                          text['delete']![
                                              widget.user!.setting.language]!,
                                          style: appBarTextStyle.copyWith(
                                              color: Colors.red,
                                              fontSize: 20.0),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                            primary: Colors.red[100],
                                            side:
                                                BorderSide(color: Colors.red))),
                                  ],
                                )
                              ],
                            ),
                    )),
              );
            });
  }
}
