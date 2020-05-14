import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_cos/constants/firebase_keys.dart';

class User {
  final String userKey;
  final String profileImg;
  final String username;
  final String email;
  final int followers;
  final List<dynamic> followings;
  final List<dynamic> likedPosts;
  final List<dynamic> myPosts;
  final DocumentReference reference;

  User.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
      : profileImg = map[KEY_PROFILEIMG],
        username = map[KEY_USERNAME],
        email = map[KEY_EMAIL],
        likedPosts = map[KEY_LIKEDPOSTS],
        followers = map[KEY_FOLLOWERS],
        followings = map[KEY_FOLLOWINGS],
        myPosts = map[KEY_MYPOSTS];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID,
            reference: snapshot.reference);
}
