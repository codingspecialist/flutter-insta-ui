import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_cos/constants/firebase_keys.dart';
import 'package:instagram_cos/data/user.dart';
import 'package:instagram_cos/firebase/transformer.dart';

class FirestoreProvider with Transformer{
  final Firestore _firestore = Firestore.instance;

  //  return은 필요 없는 것 같다.
  void attemptCreateUser({String userKey, String email}) async{
    final DocumentReference userRef = _firestore.collection(COLLECTION_USERS).document(userKey);
    DocumentSnapshot snapshot = await userRef.get();
    _firestore.runTransaction((Transaction tx) async {
      if(!snapshot.exists){
        await tx.set(userRef, User.getMapForCreateUser(email));
      }
    });
  }

  Stream<User> connectMyUserData(String userKey){
    return _firestore.collection(COLLECTION_USERS).document(userKey).snapshots().transform(toUser);
  }

  Stream<List<User>> fetchAllUsers(){
    return _firestore.collection(COLLECTION_USERS).snapshots().transform(toUsers);
  }

  Stream<List<User>> fetchAllUsersExceptMine(){
    return _firestore.collection(COLLECTION_USERS)
        .snapshots().transform(toUsers);
  }
//  Future<void> sendData(){
//    return Firestore.instance
//        .collection('Users')
//        .document('1')
//        .setData({'email' : 'cos@nate.com', 'author' : 'cos'});
//  }
//
//  Stream<dynamic> getData(){
//    Firestore.instance
//        .collection('Users')
//        .document('1')
//        .get()
//        .then((DocumentSnapshot ds){
//          print('ds.data : ${ds.data}');
//    });
//  }
}

FirestoreProvider firestoreProvider = FirestoreProvider();