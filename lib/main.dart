import 'package:flutter/material.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salut - здоровье',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      routes: {
        "/login": (context) => LoginPage(),
        "/main": (context) => MainPage(),
      },
      home: LoginPage(),
    );
  }
}