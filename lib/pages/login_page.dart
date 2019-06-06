import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Войти', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500)),
              
            ],
          ),
        ),
      ),
    );
  }
}
