import 'package:city_bank/model/superUser.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ETimer {
  Future getDate(SuperUser? user) async {
    String error =
        user == null ? 'No Date Data' : text['noDate']![user.setting.language]!;
    try {
      Response _receiver = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/Asia/Taipei'));
      Map data = jsonDecode(_receiver.body);

      DateTime now = DateTime.parse(data['utc_datetime']);
      return DateFormat('MM.dd.yyyy').format(now);
    } catch (e) {
      print(e);
      return error;
    }
  }

  Future getTime(SuperUser? user) async {
    String error =
        user == null ? 'No Date Data' : text['noTime']![user.setting.language]!;
    try {
      Response _receiver = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/Asia/Taipei'));
      Map data = jsonDecode(_receiver.body);
      DateTime now = DateTime.parse(data['utc_datetime']);

      return DateFormat('HH:mm:ss').format(now);
    } catch (e) {
      print(e);
      return error;
    }
  }
}
