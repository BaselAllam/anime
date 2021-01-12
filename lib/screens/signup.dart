import 'package:anime/screens/bottomnavbar/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




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
TextEditingController addressController = TextEditingController();

GlobalKey<FormState> emailKey = GlobalKey<FormState>();
GlobalKey<FormState> userNameKey = GlobalKey<FormState>();
GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
GlobalKey<FormState> confirmPasswordKey = GlobalKey<FormState>();
GlobalKey<FormState> addressKey = GlobalKey<FormState>();

final _formKey = GlobalKey<FormState>();

String gender = 'Select Gender';

bool check = false;

DateTime pickedDate = DateTime.now();

Position position;

Location location;

bool _isMapLoading = true;

List<Marker> markers = [];

@override
void initState(){
  locationMethod();
  super.initState();
}

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
            field(Icons.location_on, 'address', TextInputType.text, addressController, false, null, addressKey),
            Container(
              height: MediaQuery.of(context).size.height/2.5,
              margin: EdgeInsets.all(10.0),
              child: _isMapLoading == true ? Center(child: CircularProgressIndicator()) : buildMap()
            ),
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
            item('Birth Date',
              pickedDate.toString().substring(0, 11),
              Icon(Icons.date_range, color: Colors.grey, size: 20.0),
              () async {
                DateTime _pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                );
                if(_pickedDate == null){
                  setState(() {
                    pickedDate = DateTime.now();
                  });
                }else{
                  setState(() {
                    pickedDate = _pickedDate;
                  });
                }
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
        controller: controller,
        onFieldSubmitted: (value){
          if(label == 'address'){
            return searchLocation(addressController.text);
          }else{
            return null;
          }
        }
      ),
    );
  }
  locationMethod() async {

    setState(() {
      _isMapLoading = true;
    });

    bool _enabled = await  Geolocator.isLocationServiceEnabled();
    if(_enabled == false){
      setState(() {
        _isMapLoading = false;
      });
      return false;
    }else{
      Position _currentPosition = await Geolocator.getCurrentPosition();
      Marker _newMarker = Marker(
        position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        markerId: MarkerId('2')
      );
      setState(() {
        position = _currentPosition;
        markers.add(_newMarker);
        _isMapLoading = false;
      });
    }
  }
  searchLocation(String searchWord) async {
    
    setState(() {
      _isMapLoading = true;
    });

    List<Location> _search = await locationFromAddress(searchWord);
    Marker _newMarker = Marker(
      position: LatLng(_search[0].latitude, _search[0].longitude),
      markerId: MarkerId('1')
    );
    setState(() {
      location = _search[0];
      markers.add(_newMarker);
      _isMapLoading = false;
    });
  }
  buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: addressController.text.isEmpty ? LatLng(position.latitude, position.longitude) : LatLng(location.latitude, location.longitude),
        zoom: 12
      ),
      markers: Set.from(markers),
    );
  }
}