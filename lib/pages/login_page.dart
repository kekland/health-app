import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/design/card_widget.dart';
import 'package:health_app/design/text_field.dart';
import 'package:health_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String pin = "";
  String password = "";

  Future login(BuildContext context) async {
    try {
      showLoadingDialog(context: context, color: Colors.blue);
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "$pin@salut.com", password: password);

      FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

      (await SharedPreferences.getInstance()).setString("pin", pin);

      String token = await (_firebaseMessaging.getToken());
      _firebaseMessaging.requestNotificationPermissions();
      
      FirebaseDatabase.instance
          .reference()
          .child("patients")
          .child(pin)
          .child("cloudMessagingId")
          .set(token);
      
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, "/main");
    } catch (e) {
      Navigator.of(context).pop();
      showErrorSnackbarKeyed(
          key: scaffoldKey,
          context: context,
          errorMessage: "Произошла ошибка.",
          exception: e);
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18.0),
                child: CardWidget(
                  padding: const EdgeInsets.all(24.0),
                  actions: <Widget>[
                    SizedBox(
                      height: 56.0,
                      child: FlatButton(
                        child: Text("Войти"),
                        onPressed: () => login(context),
                        textColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.zero,
                                bottom: Radius.circular(12.0))),
                      ),
                    ),
                  ],
                  body: Column(
                    children: [
                      Text(
                        'Вход в систему',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 16.0),
                      ModernTextField(
                        keyboardType: TextInputType.number,
                        onChanged: (text) => setState(() => pin = text),
                        hintText: "ИИН",
                        icon: FontAwesomeIcons.solidGrin,
                      ),
                      SizedBox(height: 16.0),
                      ModernTextField(
                        onChanged: (text) => setState(() => password = text),
                        hintText: "Пароль",
                        icon: FontAwesomeIcons.lock,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
