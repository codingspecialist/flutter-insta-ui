import 'package:flutter/cupertino.dart';
import 'package:instagram_cos/data/user.dart';

// 해당 오브젝트를 지켜보고 있는 모든 위젯들에게 변경 되었다는 것을 알려줄 수 있다.
class MyUserData extends ChangeNotifier{
  User _myUserData;

  User get data => _myUserData;

  void setUserData(User user){
    _myUserData = user;
    notifyListeners(); //
  }

  void clearUser(){
    _myUserData = null;
    notifyListeners();
  }
}