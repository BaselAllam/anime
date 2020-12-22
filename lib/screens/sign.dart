import 'package:anime/screens/signin.dart';
import 'package:anime/screens/signup.dart';
import 'package:flutter/material.dart';




class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> with TickerProviderStateMixin {

TabController tabController;

@override
void initState(){
  tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 40.0),
          child: TabBar(
            tabs: [
              Text('Sing in'), Text('Sign up')
            ],
            controller: tabController,
            labelColor: Colors.black,
            labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black, width: 0.5)
            )
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: TabBarView(
          controller: tabController,
          children: [
            SignIn(),
            SignUp()
          ],
        ),
      ),
    );
  }
}