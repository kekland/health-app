import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/design/card_widget.dart';
import 'package:health_app/design/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNumber = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.pink],
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
                        onPressed: () {},
                        textColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                  ],
                  body: Column(
                    children: [
                      Text(
                        'Войти',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 16.0),
                      ModernTextField(
                        onChanged: (text) => setState(() => phoneNumber = text),
                        hintText: "Номер телефона",
                        prefix: Text("+7"),
                        icon: FontAwesomeIcons.phone,
                      ),
                      SizedBox(height: 16.0),
                      ModernTextField(
                        onChanged: (text) => setState(() => phoneNumber = text),
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
