import 'package:city_bank/model/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServices {
  final uid;
  CollectionReference? collection;
  DataBaseServices({required this.uid}) {
    collection = FirebaseFirestore.instance.collection(uid);
  }

  Future updateData(String doc, Map<String, dynamic> data) async {
    try {
      return await collection!.doc(doc).set(data);
    } catch (e) {
      print(e);
      print('error occur');
    }
  }

  Future<Map<String, dynamic>?> getData(String data) async {
    try {
      var doc = await collection!.doc(data).get();
      return doc.data() as Map<String, dynamic>;
    } catch (e) {
      print(e);
      print('error occur');
      return null;
    }
  }

  Future deleteData(String key, String date) async {
    try {
      Map<String, dynamic>? data = await getData(date);
      dynamic _deleteData = data!.remove(key);
      await updateData(date, data);
      return _deleteData;
    } catch (e) {
      return null;
    }
  }

  Future fixData(String key, String date, Event event) async {
    try {
      Map<String, dynamic>? data = await getData(date);
      if (data!.containsKey(key)) {
        data[key] = event.getMap();
        await updateData(date, data);
        return event;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
