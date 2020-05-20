import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cos/data/provider/my_user_data.dart';
import 'package:instagram_cos/firebase/firestore_provider.dart';
import 'package:instagram_cos/main_page.dart';
import 'package:instagram_cos/screens/auth_page.dart';
import 'package:instagram_cos/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'constants/material_white_color.dart';

bool isItFirstData = true;

void main() => runApp(ChangeNotifierProvider<MyUserData>(
    create: (context) => MyUserData(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<FirebaseUser>(
          // 로그인 상태가 변경되면 자동으로 트리거가 된다.
          stream: FirebaseAuth.instance.onAuthStateChanged,
          // 유저가 로그인을 했으면 stream을 통해서 user를 준다. 안했으면 null을 준다.
          builder: (context, snapshot) {
            if (isItFirstData) {
              isItFirstData = false;
              return MyProgressIndicator();
            } else {
              if (snapshot.hasData) { // data가 있다는 것은 유저가 있다는 것
                // provider 알림 설정 완료 : 이제 필요한 곳에서 사용하면 됨(myUserData)
                var myUserData = Provider.of<MyUserData>(context);
                firestoreProvider.connectMyUserData(snapshot.data.uid).listen((user) {
                  myUserData.setUserData(user);
                });

                return MainPage();
              }
              return AuthPage();
            }
          }),
      theme: ThemeData(primarySwatch: white),
    );
  }
}
