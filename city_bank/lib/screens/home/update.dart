import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/services/database.dart';
import 'package:city_bank/services/time.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  String? category;

  String? details;

  String? place;

  String? time;

  int? price;

  int num = 0;
  var showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: DraggableScrollableSheet(
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
                  color: Colors.brown[50],
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: SingleChildScrollView(
                    controller: scroller,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: showLoading
                        ? Column(
                            children: [
                              SizedBox(height: 230.0),
                              SpinKitThreeBounce(
                                color: Colors.brown[400],
                                size: 30.0,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                  text['updating']![
                                      widget.user!.setting.language]!,
                                  style: timeStyle.copyWith(
                                      color: Colors.brown[400],
                                      fontSize: 40.0)),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  text['update']![
                                      widget.user!.setting.language]!,
                                  style: timeStyle.copyWith(fontSize: 30.0)),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                text['category']![
                                    widget.user!.setting.language]!,
                                style: timeStyle.copyWith(
                                    fontSize: 20.0, color: Colors.brown),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              DropdownButtonFormField(
                                  validator: (value) {
                                    return value == null
                                        ? text['noCategory']![
                                            widget.user!.setting.language]!
                                        : null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      category = value!.toString();
                                    });
                                  },
                                  decoration: inputDecoration.copyWith(
                                    hintText: text['category']![
                                        widget.user!.setting.language]!,
                                  ),
                                  elevation: 0,
                                  items: categoryList.map((name) {
                                    return DropdownMenuItem(
                                        value: name,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(
                                              'images/${name.toLowerCase()}.png',
                                              width: 50,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Text(
                                                text[name]![widget
                                                    .user!.setting.language]!,
                                                style: appBarTextStyle.copyWith(
                                                    color: Colors.black))
                                          ],
                                        ));
                                  }).toList()),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                text['detail']![widget.user!.setting.language]!,
                                style: timeStyle.copyWith(
                                    fontSize: 20.0, color: Colors.brown),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                validator: (value) {
                                  return value!.isEmpty
                                      ? text['noDetails']![
                                          widget.user!.setting.language]!
                                      : null;
                                },
                                decoration: inputDecoration.copyWith(
                                    hintText: text['detail']![
                                        widget.user!.setting.language]!),
                                onChanged: (value) {
                                  details = value;
                                },
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                text['price']![widget.user!.setting.language]!,
                                style: timeStyle.copyWith(
                                    fontSize: 20.0, color: Colors.brown),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                validator: (value) {
                                  return value!.isEmpty
                                      ? text['noPrice']![
                                          widget.user!.setting.language]!
                                      : int.tryParse(value) != null
                                          ? null
                                          : text['notInt']![
                                              widget.user!.setting.language]!;
                                },
                                decoration: inputDecoration.copyWith(
                                    hintText: text['price']![
                                        widget.user!.setting.language]!),
                                onChanged: (value) {
                                  if (int.tryParse(value) != null)
                                    price = int.parse(value);
                                },
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      showLoading = true;
                                    });
                                    DataBaseServices services =
                                        DataBaseServices(uid: widget.user!.uid);
                                    time = await ETimer().getTime(widget.user);
                                    Map<String, dynamic>? oldData =
                                        await services.getData(widget.date) ??
                                            {};

                                    var data = Event(
                                        category: category!,
                                        details: details!,
                                        time: time!,
                                        price: price!);

                                    oldData[data.enCode()] = data.getMap();

                                    await services.updateData(
                                        widget.date, oldData);
                                    await widget.func();
                                    Navigator.pop(context);
                                  }
                                },
                                icon: Icon(Icons.upload),
                                label: Text(
                                  text['upload']![
                                      widget.user!.setting.language]!,
                                  style: appBarTextStyle,
                                ),
                                style: elevatedButtonStyle,
                              )
                            ],
                          ),
                  ),
                ),
              );
            }));
  }
}
