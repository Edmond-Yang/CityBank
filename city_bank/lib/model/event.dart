class Event {
  final _encodeList = "abcdefghijklmnopqrstuvwxyz";

  String category;
  String details;
  String time;
  int price;

  int hour = 0;
  int minute = 0;
  int second = 0;

  Event(
      {required this.category,
      required this.details,
      required this.time,
      required this.price}) {
    print(time);
    hour = int.parse(this.time.substring(0, 2));
    minute = int.parse(this.time.substring(3, 5));
    second = int.parse(this.time.substring(6, 8));
  }

  Map<String, dynamic> getMap() {
    return {
      'category': category,
      'details': details,
      'time': time,
      'price': price
    };
  }

  String enCode() {
    String ans = "";
    print(time);

    for (int i = 0; i < 8; i++) {
      if (i == 2 || i == 5) continue;

      ans = ans + _encodeList[int.parse(this.time.substring(i, i + 1))];
    }
    return ans;
  }

  bool isEarly(Event other) {
    if (this.hour != other.hour) return this.hour < other.hour;
    if (this.minute != other.minute) return this.minute < other.minute;
    if (this.second != other.second) return this.second < other.second;
    return false;
  }
}
