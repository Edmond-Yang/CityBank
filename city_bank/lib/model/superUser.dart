import 'package:city_bank/model/settings.dart';

class SuperUser {
  String uid;
  Setting setting = Setting();

  SuperUser({required this.uid});

  void setSetting({required String data}) {
    setting.language = data;
  }

  Map<String, dynamic> getSettingMap() {
    return {'language': setting.language};
  }
}
