import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final Event event;
  final SuperUser? user;
  const EventTile({Key? key, required this.event, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showModal() {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return DraggableScrollableSheet(
                initialChildSize: 0.65,
                maxChildSize: 0.65,
                minChildSize: 0.65,
                builder: (context, scroller) {
                  return Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        controller: scroller,
                        child: Column(
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
                              text['info']![user!.setting.language]!,
                              style: timeStyle,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Image.asset(
                              'images/${event.category.toLowerCase()}.png',
                              height: 80.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(text['category']![user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  event.category,
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
                                Text(text['detail']![user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  event.details,
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
                                Text(text['time']![user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  event.time,
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
                                Text(text['price']![user!.setting.language]!,
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 20.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  '${event.price}',
                                  style: TextStyle(
                                      fontFamily: 'Nunito', fontSize: 25.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                });
          });
    }

    return TextButton(
      onPressed: showModal,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
            child: ListTile(
          leading: Image.asset('images/${event.category.toLowerCase()}.png',
              width: 80),
          title: Text(
            event.details,
            style: TextStyle(fontFamily: 'Nunito', fontSize: 20.0),
          ),
          subtitle: Text(
            event.category,
            style: TextStyle(fontFamily: 'Nunito', fontSize: 20.0),
          ),
          trailing: Text('\$ ${event.price}'),
        )),
      ),
      style: TextButton.styleFrom(primary: Colors.brown[50]),
    );
  }
}
