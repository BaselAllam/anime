import 'package:anime/models/mainmodel.dart';
import 'package:anime/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MainModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreens(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            centerTitle: false,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black, size: 25.0),
            textTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}