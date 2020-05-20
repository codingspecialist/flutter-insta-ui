import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_cos/data/user.dart';

class Transformer{
  final toUser = StreamTransformer<DocumentSnapshot, User>.fromHandlers(
    handleData: (snapshot, sink) async { // sink는 싱크대에 물을 내려보내는 객체
      sink.add(User.fromSnapshot(snapshot));
    }
  );

  // QuerySnapshot은 여러개의 document
  final toUsers = StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
    handleData: (snapshot, sink){
      List<User> users = [];
      snapshot.documents.forEach((document){
        users.add(User.fromSnapshot(document));
      });
      sink.add(users);
    }
  );

  // firebase의 Auth의 uid를 firestore에서 user회원가입시에 매칭시키기 위해 uid를 documentId로 세팅한다.
  final toUsersExceptMine = StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
      handleData: (snapshot, sink) async {
        List<User> users = [];
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        snapshot.documents.forEach((document){
          if(document.documentID != user.uid)
            users.add(User.fromSnapshot(document));
        });
        sink.add(users);
      }
  );
}