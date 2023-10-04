import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setDateTime(DateTime datetime, String name, String desc) async {
    try {
      var id = const Uuid().v1();
      await _firestore
          .collection("DateTime")
          .doc(id)
          .set({'id': id, 'datetime': datetime, 'name': name, 'desc': desc});
      print('Data set');
    } catch (e) {
      print(e.toString());
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  Future<Map<String, dynamic>> getDateTime(String id) async {
    Map<String, dynamic> data = {
      'hasdata': false,
    };
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("DateTime").doc(id).get();
      data = {
        'name': snapshot['name'],
        'desc': snapshot['desc'],
        'id': snapshot['id'],
        'datetime': snapshot['datetime'],
        'hasdata': true,
      };
    } catch (e) {
      print(e.toString());
    }
    return data;
  }
}
