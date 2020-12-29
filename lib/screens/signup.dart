import 'package:anime/screens/bottomnavbar/bottomnavbar.dart';
import 'package:flutter/material.dart';




class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

bool secure = true;

TextEditingController emailController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

GlobalKey<FormState> emailKey = GlobalKey<FormState>();
GlobalKey<FormState> userNameKey = GlobalKey<FormState>();
GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
GlobalKey<FormState> confirmPasswordKey = GlobalKey<FormState>();

final _formKey = GlobalKey<FormState>();

String gender = 'Select Gender';

bool check = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _formKey,
          child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            field(Icons.account_box, 'user name', TextInputType.text, userNameController, false, null, userNameKey),
            field(Icons.email, 'email address', TextInputType.emailAddress, emailController, false, null, emailKey),
            field(Icons.lock, 'password', TextInputType.text, passwordController, secure, lockButton(), passwordKey),
            field(Icons.lock, 'confirm password', TextInputType.text, confirmPasswordController, secure, lockButton(), confirmPasswordKey),
            item('Gender', gender,
            PopupMenuButton(
                icon: Icon(Icons.arrow_circle_down, color: Colors.grey, size: 20.0),
                itemBuilder: (BuildContext context){
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      child: Text(
                        'Male',
                        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      value: 'Male'
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Female',
                        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      value: 'Female'
                    ),
                  ];
                },
                onSelected: (value){
                  setState((){
                    gender = value;
                  });
                },
              ),
              () {}
            ),
            item('Terms & Condtions', 'Read our Terms & Conditions',
            Checkbox(
              activeColor: Colors.black,
              checkColor: Colors.white,
              hoverColor: Colors.black,
              value: check,
              onChanged: (value) {
                setState((){
                  check = value;
                });
              },
            ),
            () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                builder: (BuildContext context){
                  return ListTile(
                    title: Text(
                        'Our Terms and Conditions',
                        style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    subtitle: Text(
                      '1- your data is unsaffe\n2- dont use our app\n3- abo el magad whos developed it\n1- your data is unsaffe\n2- dont use our app\n3- abo el magad whos developed it',
                      style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              );
            }
            ),
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: Text(
                  'Signup',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              color: Colors.black,
              onPressed: () {
                if(!_formKey.currentState.validate()){
                  return Scaffold.of(context).showSnackBar(
                    snack('some fields required!'),
                  );
                }else if(passwordController.text != confirmPasswordController.text){
                  return Scaffold.of(context).showSnackBar(
                    snack('password dont matched'),
                  );
                }else if(gender == 'Select Gender'){
                  return Scaffold.of(context).showSnackBar(
                    snack('select your gender'),
                  );
                }else if(check == false){
                  return Scaffold.of(context).showSnackBar(
                    snack('kindly accept terms & conditions'),
                  );
                }else{
                  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                }
              }
            ),
          ],
        ),
      ),
    );
  }
  snack(String content) {
    return SnackBar(
      content: Text(
        content,
        style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 4),
    );
  }
  item(String title, String subTitle, Widget trailing, Function onTap) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: ListTile(
        title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        subtitle: Text(
            subTitle,
            style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.normal),
          ),
        trailing: trailing,
        onTap: onTap
      ),
    );
  }
  lockButton() {
    return IconButton(
      icon: Icon(Icons.remove_red_eye),
      color: Colors.black,
      iconSize: 20.0,
      onPressed: () {
        setState(() {
          secure = !secure;
        });
      }
    );
  }
  field(IconData icon, String label, TextInputType type, TextEditingController controller, bool obsecure, Widget lock, Key key) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: key,
        validator: (value) {
          if(value.isEmpty){
            return 'this field required';
          }else{
            return null;
          }
        },
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
          suffixIcon: lock
        ),
        keyboardType: type,
        obscureText: obsecure,
        controller: controller
      ),
    );
  }
}