import 'package:anime/screens/bottomnavbar/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

bool secure = true;

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          field(Icons.email, 'email address', TextInputType.emailAddress, emailController),
          field(Icons.lock, 'password', TextInputType.text, passwordController),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
                onTap: () {},
                child: Text(
                'Forgot Password?!',
                style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold, height: 2.0),
              ),
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            color: Colors.black,
            onPressed: () async {
              SharedPreferences _user = await SharedPreferences.getInstance();
              _user.setString('email', emailController.text);
              return Navigator.push(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
            }
          ),
        ],
      ),
    );
  }
  field(IconData icon, String label, TextInputType type, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.black, width: 1.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.black, width: 1.0)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.red, width: 1.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.black, width: 1.0)
          ),
          prefixIcon: Icon(icon, color: Colors.black, size: 20.0),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
          suffixIcon: label == 'password' ? IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Colors.black,
            iconSize: 20.0,
            onPressed: () {
              setState(() {
                secure = !secure;
              });
            }
          ) : null
        ),
        keyboardType: type,
        obscureText: label == 'password' ? secure : false,
        controller: controller
      ),
    );
  }
}