import 'package:flutter/material.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
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
              prefixIcon: Icon(Icons.email, color: Colors.black, size: 20.0),
              labelText: 'email address',
              labelStyle: TextStyle(color: Colors.black, fontSize: 15.0)
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
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
              prefixIcon: Icon(Icons.lock, color: Colors.black, size: 20.0),
              labelText: 'password',
              labelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: Colors.black,
                iconSize: 20.0,
                onPressed: () {
                  setState(() {
                    secure = !secure;
                  });
                }
              )
            ),
            keyboardType: TextInputType.text,
            obscureText: secure,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Forgot Password?!',
              style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold, height: 2.0),
            ),
          ),

        ],
      ),
    );
  }
}