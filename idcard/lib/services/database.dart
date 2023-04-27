import 'package:flutter/material.dart';
import 'package:idcard/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('idc');

  Future printUrl(String email) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("$email");
    String url = (await ref.getDownloadURL()).toString();
    print(url);
    return NetworkImage(url);
  }

  //UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['name'],
      phone: snapshot['phone'],
      email: snapshot['email'],
      position: snapshot['position'],
      address: snapshot['address'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
