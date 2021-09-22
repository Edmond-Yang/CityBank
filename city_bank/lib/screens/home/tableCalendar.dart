import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class CalendarTable extends StatefulWidget {
  final SuperUser? user;
  final String date;
  Function changeTime;
  CalendarTable(
      {Key? key,
      required this.user,
      required this.changeTime,
      required this.date})
      : super(key: key);

  @override
  _CalendarTableState createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  var selectDay;
  var month;
  String? language;
  var showLoading = false;
  @override
  void initState() {
    super.initState();
    language =
        {'English': 'en_US', '中文': 'zh_CN'}[widget.user!.setting.language];
    selectDay = widget.date == "00.00.0000"
        ? DateTime.now()
        : DateTime(
            int.parse(widget.date.substring(6)),
            int.parse(widget.date.substring(0, 2)),
            int.parse(widget.date.substring(3, 5)));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        maxChildSize: 0.75,
        minChildSize: 0.75,
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
                      child: showLoading
                          ? Column(
                              children: [
                                SizedBox(height: 230.0),
                                SpinKitThreeBounce(
                                  color: Colors.brown[400],
                                  size: 33.0,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                    text['updating']![
                                        widget.user!.setting.language]!,
                                    style: timeStyle.copyWith(
                                        color: Colors.brown[400],
                                        fontSize: 30.0)),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
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
                                Center(
                                  child: Text(
                                    text['calendar']![
                                        widget.user!.setting.language]!,
                                    style: timeStyle.copyWith(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TableCalendar(
                                  // Calendar Style
                                  locale: language,
                                  calendarFormat: CalendarFormat.month,
                                  calendarStyle: CalendarStyle(
                                      isTodayHighlighted: true,
                                      todayDecoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      todayTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      selectedDecoration: BoxDecoration(
                                        color: Colors.brown[300],
                                        shape: BoxShape.circle,
                                      ),
                                      selectedTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),

                                  // Header Style

                                  headerStyle: HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true),

                                  // Day
                                  focusedDay: selectDay,
                                  firstDay: DateTime(2021),
                                  lastDay: DateTime.now(),

                                  // Select Day
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectDay, day);
                                  },

                                  onDaySelected: (_selectDay, _focusDay) async {
                                    setState(() {
                                      selectDay = _selectDay;
                                      showLoading = true;
                                    });
                                    await widget.changeTime(
                                        DateFormat('MM.dd.yyyy')
                                            .format(_selectDay));
                                  },
                                  onHeaderTapped: (now) {},
                                ),
                              ],
                            ))));
        });
  }
}
