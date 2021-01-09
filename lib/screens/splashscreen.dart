import 'package:anime/screens/bottomnavbar/bottomnavbar.dart';
import 'package:anime/screens/sign.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';





class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {

String email;

@override
void initState() {
  checkUser();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: email == null ? Sign() : BottomNavBar(),
      title: new Text(
        'Welcome In Anime',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Anime_eye.svg/1200px-Anime_eye.svg.png'),
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
    );
  }
  checkUser() async {
    SharedPreferences _user = await SharedPreferences.getInstance();
    String _email = _user.getString('email');
    setState(() {
      email = _email;
    });
  }
}