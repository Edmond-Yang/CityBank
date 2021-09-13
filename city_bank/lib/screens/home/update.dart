import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/services/database.dart';
import 'package:city_bank/services/time.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';

class UpdateModal extends StatefulWidget {
  final SuperUser? user;
  final date;
  Function func;

  UpdateModal(
      {Key? key, required this.user, required this.date, required this.func})
      : super(key: key);

  @override
  _UpdateModalState createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  final _formKey = GlobalKey<FormState>();
  final List<String> categoryList = [
    'Food',
    'Drink',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Housing',
    'Electronic',
    'Medical',
    'Bill',
    'Other'
  ];

  final List<String> categoryListTaiwan = [
    '食物',
    '飲料',
    '交通',
    '購物',
    '娛樂',
    '家庭用品',
    '電子產品',
    '醫療',
    '帳單',
    '其他'
  ];

  String? category;

  String? details;

  String? place;

  String? time;

  int? price;

  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text['update']![widget.user!.setting.language]!,
              style: timeStyle),
          SizedBox(
            height: 20.0,
          ),
          Text(
            text['category']![widget.user!.setting.language]!,
            style: timeStyle.copyWith(fontSize: 20.0, color: Colors.brown),
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField(
              validator: (value) {
                return value == null
                    ? text['noCategory']![widget.user!.setting.language]!
                    : null;
              },
              onChanged: (value) {
                setState(() {
                  category = value!.toString();
                });
              },
              decoration: inputDecoration.copyWith(
                hintText: text['category']![widget.user!.setting.language]!,
              ),
              elevation: 0,
              items: categoryList.map((name) {
                return DropdownMenuItem(
                    value: name,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'images/${name.toLowerCase()}.png',
                          width: 50,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(name,
                            style:
                                appBarTextStyle.copyWith(color: Colors.black))
                      ],
                    ));
              }).toList()),
          SizedBox(
            height: 30.0,
          ),
          Text(
            text['detail']![widget.user!.setting.language]!,
            style: timeStyle.copyWith(fontSize: 20.0, color: Colors.brown),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (value) {
              return value!.isEmpty
                  ? text['noDetails']![widget.user!.setting.language]!
                  : null;
            },
            decoration: inputDecoration.copyWith(
                hintText: text['detail']![widget.user!.setting.language]!),
            onChanged: (value) {
              details = value;
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            text['price']![widget.user!.setting.language]!,
            style: timeStyle.copyWith(fontSize: 20.0, color: Colors.brown),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (value) {
              return value!.isEmpty
                  ? text['noPrice']![widget.user!.setting.language]!
                  : int.tryParse(value) != null
                      ? null
                      : text['notInt']![widget.user!.setting.language]!;
            },
            decoration: inputDecoration.copyWith(
                hintText: text['price']![widget.user!.setting.language]!),
            onChanged: (value) {
              price = int.parse(value);
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                DataBaseServices services =
                    DataBaseServices(uid: widget.user!.uid);
                time = await ETimer().getTime(widget.user);
                Map<String, dynamic>? oldData =
                    await services.getData(widget.date);
                if (oldData == null) {
                  oldData = {};
                  oldData['0'] = Event(
                          category: category!,
                          details: details!,
                          time: time!,
                          price: price!)
                      .getMap();
                } else {
                  oldData['${oldData.length}'] = Event(
                          category: category!,
                          details: details!,
                          time: time!,
                          price: price!)
                      .getMap();
                }
                await services.updateData(widget.date, oldData);
                await widget.func();
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.upgrade),
            label: Text(
              text['finish']![widget.user!.setting.language]!,
              style: appBarTextStyle,
            ),
            style: elevatedButtonStyle,
          )
        ],
      ),
    );
  }
}
