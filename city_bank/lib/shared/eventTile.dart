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
          context: context,
          builder: (context) {
            return Container(
                color: Colors.brown[50],
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Column(
                  children: [
                    Text(
                      text['info']![user!.setting.language]!,
                      style: timeStyle,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Image.asset(
                      'images/${event.category.toLowerCase()}.png',
                      width: 80.0,
                    ),
                    SizedBox(
                      height: 15.0,
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
                          style:
                              TextStyle(fontFamily: 'Nunito', fontSize: 25.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
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
                          style:
                              TextStyle(fontFamily: 'Nunito', fontSize: 25.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
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
                          style:
                              TextStyle(fontFamily: 'Nunito', fontSize: 25.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
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
                          '\$ ${event.price}',
                          style:
                              TextStyle(fontFamily: 'Nunito', fontSize: 25.0),
                        ),
                      ],
                    ),
                  ],
                ));
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
