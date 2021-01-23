import 'package:anime/models/mainmodel.dart';
import 'package:anime/screens/bottomnavbar/addmovie.dart';
import 'package:anime/screens/bottomnavbar/homepage.dart';
import 'package:anime/screens/bottomnavbar/profile.dart';
import 'package:anime/screens/bottomnavbar/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Movie'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile'
          ),
        ],
        elevation: 0.0,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 25.0),
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black, fontSize: 15),
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 25.0),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 15),
        currentIndex: current,
        onTap: (index) {
          setState(() {
            current = index;
          });
        },
      ),
      body: ScopedModelDescendant(
        builder: (context, child, MainModel movie){
          return navigate(movie);
        }
      ),
    );
  }
  navigate(MainModel movie) {
    if(current == 0){
      return HomePage(movie);
    }else if(current == 1){
      return Wishlist();
    }else if(current == 2){
      return AddMovie();
    }else{
      return Profile();
    }
  }
}