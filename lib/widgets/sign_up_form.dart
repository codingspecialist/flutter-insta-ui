import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cos/constants/size.dart';
import 'package:instagram_cos/firebase/firestore_provider.dart';
import 'package:instagram_cos/main_page.dart';
import 'package:instagram_cos/service/facebook_login.dart';
import 'package:instagram_cos/utils/simple_snack_bar.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailConstroller = TextEditingController();
  TextEditingController _pwConstroller = TextEditingController();
  TextEditingController _cpwConstroller = TextEditingController();

  String logo = "assets/insta_text_logo.png";

  @protected
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          logo = visible == true ? "" : "assets/insta_text_logo.png" ;
        });
      },
    );
  }

  @override
  void dispose() {
    _emailConstroller.dispose();
    _pwConstroller.dispose();
    _cpwConstroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: common_s_gap,
                ),
                Image.asset(logo),
                SizedBox(
                  height: common_xxxs_gap,
                ),
                TextFormField(
                  controller: _emailConstroller,
                  decoration: getTextFieldDecor('Email'),
                  validator: (String value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return 'Please enter your email address!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: common_xxxs_gap,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _pwConstroller,
                  decoration: getTextFieldDecor('Password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter any password!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: common_xxxs_gap,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _cpwConstroller,
                  decoration: getTextFieldDecor('Confirm Password'),
                  validator: (String value) {
                    if (value.isEmpty || value != _pwConstroller.text) {
                      return 'Password does not match!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: common_xxxs_gap,
                ),
                FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _register;
                    }
                  },
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  disabledColor: Colors.blue[100],
                ),
                SizedBox(
                  height: common_xxxs_gap,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                        left: 0,
                        right: 0,
                        height: 1,
                        child: Container(
                          color: Colors.grey[300],
                          height: 1,
                        )),
                    Container(
                      height: 3,
                      width: 50,
                      color: Colors.grey[50],
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: common_xxxs_gap,
                ),
                FlatButton.icon(
                    textColor: Colors.blue,
                    onPressed: () {
                      signInFacebook(context);
                    },
                    icon: ImageIcon(AssetImage("assets/icon/facebook.png")),
                    label: Text("Login with Facebook")),
                SizedBox(
                  height: common_xs_gap,
                ),
                SizedBox(
                  height: common_s_gap,
                ),
              ],
            )),
      ),
    );
  }

  get _register async {
    final AuthResult result =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailConstroller.text,
      password: _pwConstroller.text,
    );

    final FirebaseUser user = result.user;

    if (user == null) {
      simpleSnackbar(context, 'Please try again later!');
    }
    firestoreProvider.attemptCreateUser(userKey: user.uid, email: _emailConstroller.text);
  }

  InputDecoration getTextFieldDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.grey[100],
        filled: true);
  }
}
