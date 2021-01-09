import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

File pickedImage;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width/3.5,
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: pickedImage == null ? NetworkImage('https://pbs.twimg.com/profile_images/1270783622434435072/nUAehm4__400x400.jpg') : FileImage(pickedImage),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Colors.black,
                      iconSize: 25.0,
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      }
                    ),
                  ),
                  Text(
                      'Bassel Allam',
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            item('baseljahen@gmailcom', Icons.email, () {}),
            item('*****', Icons.lock, () {}),
            item('20/12/1990', Icons.calendar_today, () {}),
            item('English', Icons.language, () {}),
            item('Sign out', Icons.exit_to_app, () async {
              SharedPreferences _user = await SharedPreferences.getInstance();
              _user.clear();
            })
          ],
        ),
      ),
    );
  }
  item(String title, IconData icon, Function onTap){
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black, size: 20.0),
        title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        trailing: Icon(Icons.edit, color: Colors.grey, size: 20.0),
        onTap: onTap
      ),
    );
  }
  pickImage(ImageSource source) async {

    File _pickedImage = await ImagePicker.pickImage(source: source);
    setState(() {
      pickedImage = _pickedImage;
    });
  }
}