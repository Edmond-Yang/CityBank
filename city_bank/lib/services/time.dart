import 'package:city_bank/model/superUser.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class ETimer {
  Future getDate(SuperUser? user) async {
    try {
      Response _receiver = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/Asia/Taipei'));
      Map data = jsonDecode(_receiver.body);
      DateTime now = DateTime.parse(data['utc_datetime']);

      return DateFormat('MM.dd.yyyy').format(now.add(Duration(hours: 8)));
    } catch (e) {
      print(e);
      return '00.00.0000';
    }
  }

  Future getTime(SuperUser? user) async {
    try {
      Response _receiver = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/Asia/Taipei'));
      Map data = jsonDecode(_receiver.body);
      DateTime now = DateTime.parse(data['utc_datetime']);

      return DateFormat('HH:mm:ss').format(now.add(Duration(hours: 8)));
    } catch (e) {
      print(e);
      return '00:00:00';
    }
  }
}
