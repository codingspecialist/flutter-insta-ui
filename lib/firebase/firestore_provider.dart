import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Future<void> sendData(){
    return Firestore.instance
        .collection('Users')
        .document('1')
        .setData({'email' : 'cos@nate.com', 'author' : 'cos'});
  }

  Stream<dynamic> getData(){
    Firestore.instance
        .collection('Users')
        .document('1')
        .get()
        .then((DocumentSnapshot ds){
          print('ds.data : ${ds.data}');
    });
  }
}

FirestoreProvider firestoreProvider = FirestoreProvider();