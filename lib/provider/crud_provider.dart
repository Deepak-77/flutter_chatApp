import 'package:chat_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final usersStream = StreamProvider((ref) => CrudProvider().getUserStream());

class CrudProvider{
  CollectionReference userDb = FirebaseFirestore.instance.collection('users');

  Stream<List<UserData>> getUserStream(){
    return userDb.snapshots().map((event) => getData(event));
  }

  List<UserData> getData(QuerySnapshot snapshot){
    return snapshot.docs.map((e) => UserData.fromJson(e.data() as Map<String, dynamic>)).toList();
  }





}