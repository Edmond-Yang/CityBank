import 'package:flutter/material.dart';
import 'package:city_bank/shared/constants.dart';

class Calendar extends StatelessWidget {
  final user;
  final _formKey = GlobalKey<FormState>();
  final List<String> listYear;
  final List<String> listMonth;
  final List<String> listDay;

  Function changeTime;

  String? year;
  String? month;
  String? day;

  Calendar(
      {Key? key,
      required this.user,
      required this.listYear,
      required this.listMonth,
      required this.listDay,
      required this.changeTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.83,
        maxChildSize: 0.83,
        minChildSize: 0.83,
        builder: (context, scroller) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(30, 20),
              topRight: Radius.elliptical(30, 20),
            ),
            child: Container(
              color: Colors.brown[50],
              child: SingleChildScrollView(
                controller: scroller,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close),
                              splashRadius: 5.0,
                            )
                          ],
                        ),
                        Text(
                          text['calendar']![user!.setting.language]!,
                          style: timeStyle.copyWith(
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          text['year']![user!.setting.language]!,
                          style: timeStyle.copyWith(
                              fontSize: 20.0, color: Colors.brown),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButtonFormField(
                            validator: (value) {
                              return value == null
                                  ? text['noYear']![user!.setting.language]!
                                  : null;
                            },
                            onChanged: (value) {
                              year = value!.toString();
                              print(year);
                            },
                            decoration: inputDecoration.copyWith(
                              hintText: text['year']![user!.setting.language]!,
                            ),
                            elevation: 0,
                            items: listYear.map((name) {
                              return DropdownMenuItem(
                                  value: name, child: Text(name));
                            }).toList()),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          text['month']![user!.setting.language]!,
                          style: timeStyle.copyWith(
                              fontSize: 20.0, color: Colors.brown),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButtonFormField(
                            validator: (value) {
                              return value == null
                                  ? text['noMonth']![user!.setting.language]!
                                  : null;
                            },
                            onChanged: (value) {
                              month = value!.toString().length < 2
                                  ? '0' + value.toString()
                                  : value.toString();
                            },
                            decoration: inputDecoration.copyWith(
                              hintText: text['month']![user!.setting.language]!,
                            ),
                            elevation: 0,
                            items: listMonth.map((name) {
                              return DropdownMenuItem(
                                  value: name, child: Text(name));
                            }).toList()),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          text['day']![user!.setting.language]!,
                          style: timeStyle.copyWith(
                              fontSize: 20.0, color: Colors.brown),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButtonFormField(
                            validator: (value) {
                              return value == null
                                  ? text['noDay']![user!.setting.language]!
                                  : null;
                            },
                            onChanged: (value) {
                              day = value!.toString().length < 2
                                  ? '0' + value.toString()
                                  : value.toString();
                            },
                            decoration: inputDecoration.copyWith(
                              hintText: text['day']![user!.setting.language]!,
                            ),
                            elevation: 0,
                            items: listDay.map((name) {
                              return DropdownMenuItem(
                                  value: name, child: Text(name));
                            }).toList()),
                        SizedBox(height: 30.0),
                        ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                changeTime('$month.$day.$year');
                              }
                            },
                            icon: Icon(Icons.login),
                            label: Text(text['ok']![user!.setting.language]!,
                                style: appBarTextStyle),
                            style: elevatedButtonStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
