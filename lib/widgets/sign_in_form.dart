import 'package:flutter/material.dart';
import 'package:instagram_cos/constants/size.dart';
import 'package:instagram_cos/main_page.dart';
import 'package:instagram_cos/utils/simple_snack_bar.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
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
            // ListView는 정해진 높이를 줘야한다. flex가 있는 애들은 사용할 수 없다.
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Image.asset("assets/insta_text_logo.png"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                decoration: getTextFieldDecor("Email"),
                validator: (String value) {
                  // validator는 _fromKey를 사용해서 버튼 클릭시 트리거 해준다.
                  if (value.isEmpty || !value.contains("@")) {
                    return "Please enter your email address!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _pwController,
                obscureText: true,
                decoration: getTextFieldDecor("Password"),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter any password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Forgotten password?",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final route = MaterialPageRoute(builder: (context) => MainPage());
                    Navigator.pushReplacement(context, route);
                  }
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular((6)),
                ),
                //disabledColor: Colors.blue[100],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                  ),
                  Text(
                    "  OR  ",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton.icon(
                  onPressed: () {
                    simpleSnackbar(context, "facebook pressed");
                  },
                  icon: ImageIcon(AssetImage("assets/icon/facebook.png")),
                  label: Text("Login with Facebook")),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration getTextFieldDecor(String hint) => InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300], width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300], width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      fillColor: Colors.grey[100],
      filled: true);
}
