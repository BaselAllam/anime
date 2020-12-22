import 'package:anime/screens/sign.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sign(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          centerTitle: false,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black, size: 25.0),
          textTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}