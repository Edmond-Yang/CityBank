import 'package:city_bank/model/event.dart';
import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/screens/home/eventList.dart';
import 'package:city_bank/screens/home/setting.dart';
import 'package:city_bank/screens/home/tableCalendar.dart';
import 'package:city_bank/screens/home/update.dart';
import 'package:city_bank/screens/loading.dart';
import 'package:city_bank/services/database.dart';
import 'package:city_bank/services/time.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  SuperUser? user;
  Home({Key? key, required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var time = '';
  Map<String, dynamic>? data;
  bool showLoading = true;

  void changeLang(String lang) {
    setState(() {
      widget.user!.setSetting(data: lang);
    });
  }

  Future runTile() async {
    setState(() {
      showLoading = true;
    });
    data = await DataBaseServices(uid: widget.user!.uid).getData(time);
    setState(() {
      showLoading = false;
    });
  }

  Event eventFromMap(Map data) {
    return Event(
        category: data['category'],
        time: data['time'],
        details: data['details'],
        price: data['price']);
  }

  void getInfo() async {
    Map? receiver =
        await DataBaseServices(uid: widget.user!.uid).getData('setting') as Map;
    widget.user!.setSetting(data: receiver['language']);
    time = await ETimer().getDate(widget.user);
    data = await DataBaseServices(uid: widget.user!.uid).getData(time);

    setState(() {
      showLoading = false;
    });
  }

  void showSetting() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SettingModal(
            changeLang: changeLang,
            user: widget.user,
          );
        });
  }

  void showCalendar() {
    void change(String currentTime) async {
      time = currentTime;
      data = await DataBaseServices(uid: widget.user!.uid).getData(time);

      setState(() {
        print(time);
        Navigator.pop(context);
      });
    }

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CalendarTable(
              user: widget.user, changeTime: change, date: time);
        });
  }

  void showUpdate() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return UpdateModal(
            user: widget.user,
            date: time,
            func: runTile,
          );
        });
  }

  int countTotal() {
    int count = 0;
    data!.forEach((key, value) {
      count += eventFromMap(value).price;
    });
    return count;
  }

  void rebuilt() async {
    data = await DataBaseServices(uid: widget.user!.uid).getData(time);
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    var totalText = data == null
        ? Text(
            '${text['total']![widget.user!.setting.language]} : 0',
            style: timeStyle,
          )
        : Text(
            '${text['total']![widget.user!.setting.language]} : ${countTotal()}',
            style: timeStyle,
          );

    return showLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text(
                text['title']![widget.user!.setting.language]!,
                style: appBarTextStyle.copyWith(fontSize: 20.0),
              ),
              actions: [
                TextButton.icon(
                  onPressed: runTile,
                  icon: Icon(
                    Icons.refresh,
                    size: 22.0,
                  ),
                  label: Text(
                    text['reload']![widget.user!.setting.language]!,
                    style: appBarTextStyle,
                  ),
                  style: appBarButtonStyle,
                ),
                TextButton.icon(
                  onPressed: showCalendar,
                  icon: Icon(
                    Icons.calendar_today,
                    size: 22.0,
                  ),
                  label: Text(
                    text['calendar']![widget.user!.setting.language]!,
                    style: appBarTextStyle,
                  ),
                  style: appBarButtonStyle,
                ),
                TextButton.icon(
                  onPressed: showSetting,
                  icon: Icon(
                    Icons.settings,
                    size: 22.0,
                  ),
                  label: Text(
                    text['setting']![widget.user!.setting.language]!,
                    style: appBarTextStyle,
                  ),
                  style: appBarButtonStyle,
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/coffee_bg.png'),
                      fit: BoxFit.cover)),
              child: Scrollbar(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          time,
                          style: timeStyle,
                        ),
                        SizedBox(
                          width: 60.0,
                        ),
                        totalText
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    EventList(
                      user: widget.user,
                      listEvent: data,
                      date: time,
                      rebuilt: rebuilt,
                    ),
                  ],
                ),
              )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: showUpdate,
              child: Icon(Icons.add),
              backgroundColor: Colors.brown[400],
            ),
          );
  }
}
