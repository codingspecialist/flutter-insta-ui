import 'package:flutter/material.dart';
import 'package:instagram_cos/widgets/sign_in_form.dart';
import 'package:instagram_cos/widgets/sign_up_form.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Widget currentWidget = SignInForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AnimatedSwitcher(duration: Duration(milliseconds: 300), child: currentWidget),
            _goToSignBtn(context),
          ],
        ),
      ),
    );
  }

  Positioned _goToSignBtn(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 40,
      child: FlatButton(
        shape: Border(top: BorderSide(color: Colors.grey[300])),
        onPressed: () {
          setState(() {
            if (currentWidget is SignInForm) {
              // is 는 타입 비교이다.
              currentWidget = SignUpForm();
            } else {
              currentWidget = SignInForm();
            }
          });
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: (currentWidget is SignInForm)
                    ? "Don't hava an account?"
                    : "Already have an account?",
                style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black54)),
            TextSpan(
                text: (currentWidget is SignInForm) ? "   Sign Up" : "   Sign In",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[600])),
          ]),
        ),
      ),
    );
  }
}
