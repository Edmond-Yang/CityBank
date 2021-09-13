class Event {
  String category;
  String details;
  String time;
  int price;

  Event(
      {required this.category,
      required this.details,
      required this.time,
      required this.price});

  Map<String, dynamic> getMap() {
    return {
      'category': category,
      'details': details,
      'time': time,
      'price': price
    };
  }
}
