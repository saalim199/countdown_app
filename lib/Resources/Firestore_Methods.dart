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
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  Future<void> deleteData(String id) async {
    try {
      await _firestore.collection('DateTime').doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
