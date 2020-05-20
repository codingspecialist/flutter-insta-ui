import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cos/constants/size.dart';
import 'package:instagram_cos/data/provider/my_user_data.dart';
import 'package:instagram_cos/screens/auth_page.dart';
import 'package:provider/provider.dart';

class ProfileSideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.grey[300]),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: Text(
              'Settings',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.grey[300],
            height: 1,
          ),
          FlatButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              // listen: false는 해당 위젯을 rebuild하지 말라는 뜻이다.
              Provider.of<MyUserData>(context, listen: false).clearUser(); // 하위 context는 부모 위젯트리의 context를 포함한다.
//              final route = MaterialPageRoute(builder: (context) => AuthPage());
//              Navigator.pushReplacement(context, route); // 스택이 쌓이지 않고 화면이 변경된다. pushReplacement
            },
            icon: Icon(Icons.exit_to_app),
            label: Text(
              'Log out',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
