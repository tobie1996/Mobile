import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyFirebase {
  static final _db = FirebaseFirestore.instance;
  static final contactsCollection = _db.collection('employe');
}

abstract class MyFirebase2 {
  static final _db = FirebaseFirestore.instance;
  static final contactsCollection = _db.collection('poste');
}