import 'package:flutter/material.dart';

var text = {
  'title': {'English': 'City Bank', '中文': '城市銀行'},
  'noDate': {'English': 'No Date Data', '中文': '無日期資料'},
  'noTime': {'English': 'No Time data', '中文': '無時間資料'},
  'calendar': {'English': 'Calendar', '中文': '月曆'},
  'setting': {'English': 'Setting', '中文': '設置'},
  'logout': {'English': 'Log Out', '中文': '登出'},
  'language': {'English': 'Language', '中文': '語言'},
  'update': {'English': 'Update', '中文': '上傳'},
  'category': {'English': 'Category', '中文': '類別'},
  'detail': {'English': 'Detail', '中文': '明細'},
  'price': {'English': 'Price', '中文': '價格'},
  'upload': {'English': 'Upload', '中文': '上傳'},
  'info': {'English': 'Information', '中文': '資訊'},
  'time': {'English': 'Time', '中文': '時間'},
  'noData': {'English': 'No Data', '中文': '無資料'},
  'year': {'English': 'Year', '中文': '年'},
  'month': {'English': 'Month', '中文': '月'},
  'day': {'English': 'Day', '中文': '日'},
  'noCategory': {'English': 'Please Choose a Category', '中文': '請選擇一個類別'},
  'noDetails': {'English': 'Please Enter Details', '中文': '請輸入明細'},
  'noPrice': {'English': 'Please Enter Price', '中文': '請輸入價格'},
  'notInt': {'English': 'Please Enter Integar', '中文': '請輸入整數'},
  'noYear': {'English': 'Please Choose a Year', '中文': '請選擇年份'},
  'noMonth': {'English': 'Please Choose a Month', '中文': '請選擇月份'},
  'noDay': {'English': 'Please Choose a Day', '中文': '請選擇日子'},
  'ok': {'English': 'OK', '中文': '好了'},
  'total': {'English': 'Total', '中文': '總計'},
  'delete': {'English': 'Delete', '中文': '刪除'},
  'version': {'English': 'Version', '中文': '版本'},
  'reload': {'English': 'Reload', '中文': '重載'},
  'Food': {'English': 'Food', '中文': '食物'},
  'Drink': {'English': 'Drink', '中文': '飲料'},
  'Transportation': {'English': 'Transportation', '中文': '交通'},
  'Shopping': {'English': 'Shopping', '中文': '購物'},
  'Entertainment': {'English': 'Entertainment', '中文': '娛樂'},
  'Housing': {'English': 'Housing', '中文': '家庭用品'},
  'Electronic': {'English': 'Electronic', '中文': '電子產品'},
  'Medical': {'English': 'Medical', '中文': '醫療'},
  'Bill': {'English': 'Bill', '中文': '帳單'},
  'Other': {'English': 'Other', '中文': '其他'},
  'updating': {'English': 'Updating', '中文': '上傳中'},
  'loading': {'English': 'Loading', '中文': '載入中'},
  'deleting': {'English': 'Deleting', '中文': '刪除中'},
  'fixing': {'English': 'Modifing', '中文': '修改中'},
  'fix': {'English': 'Modify', '中文': '修改'},
};

var appBarButtonStyle = TextButton.styleFrom(primary: Colors.white);

var appBarTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Nunito',
  fontWeight: FontWeight.w400,
);

var inputDecoration = InputDecoration(
  border: UnderlineInputBorder(
      borderSide: BorderSide(
    color: Colors.brown[200]!,
  )),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
    color: Colors.brown[600]!,
  )),
);

var elevatedButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.brown[400],
);

var timeStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 25.0,
    fontWeight: FontWeight.w400,
    color: Colors.black);
