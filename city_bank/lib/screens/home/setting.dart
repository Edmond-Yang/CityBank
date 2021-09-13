import 'package:city_bank/services/auth.dart';
import 'package:city_bank/services/database.dart';
import 'package:city_bank/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingModal extends StatefulWidget {
  Function changeLang;
  final user;
  SettingModal({Key? key, required this.changeLang, required this.user})
      : super(key: key);

  @override
  _SettingModalState createState() => _SettingModalState();
}

class _SettingModalState extends State<SettingModal> {
  final languages = ['English', '中文'];
  final _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  var lang;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Center(
            child: Text(
              text['setting']![widget.user.setting.language]!,
              style: timeStyle.copyWith(
                fontSize: 25.0,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              text['language']![widget.user.setting.language]!,
              style: timeStyle.copyWith(
                color: Colors.brown[600],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          DropdownButtonFormField(
              value: widget.user.setting.language,
              decoration: inputDecoration.copyWith(hintText: 'Language'),
              elevation: 0,
              onChanged: (value) {
                setState(() {
                  widget.changeLang(value.toString());
                  DataBaseServices(uid: widget.user.uid)
                      .updateData('setting', widget.user.getSettingMap());
                });
              },
              items: languages.map((choices) {
                return DropdownMenuItem(
                    value: choices,
                    child: Text(
                      choices,
                    ));
              }).toList()),
          SizedBox(height: 100.0),
          ElevatedButton.icon(
            onPressed: () async {
              Navigator.pop(context);
              await _auth.logOut();
            },
            icon: Icon(Icons.logout),
            label: Text(text['logout']![widget.user.setting.language]!,
                style: appBarTextStyle),
            style: elevatedButtonStyle,
          )
        ],
      ),
    );
  }
}
