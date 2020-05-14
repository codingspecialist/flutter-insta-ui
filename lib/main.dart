import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cos/main_page.dart';
import 'package:instagram_cos/screens/auth_page.dart';
import 'constants/material_white_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<FirebaseUser>( // 로그인 상태가 변경되면 자동으로 트리거가 된다.
        stream: FirebaseAuth.instance.onAuthStateChanged, // 유저가 로그인을 했으면 stream을 통해서 user를 준다. 안했으면 null을 준다.
        builder: (context, snapshot) {
          if(snapshot.hasData){ // data가 있다는 것은 유저가 있다는 것
            return MainPage();
          }
          return AuthPage();
        }
      ),
      theme: ThemeData(primarySwatch: white),
    );
  }
}
