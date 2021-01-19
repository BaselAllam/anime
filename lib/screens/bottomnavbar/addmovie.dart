import 'dart:io';

import 'package:anime/models/movie/moviecontroller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';




class AddMovie extends StatefulWidget {
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {

TextEditingController nameController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

final GlobalKey<FormFieldState<String>> nameKey = GlobalKey<FormFieldState<String>>();
final GlobalKey<FormFieldState<String>> priceKey = GlobalKey<FormFieldState<String>>();
final GlobalKey<FormFieldState<String>> descriptionKey = GlobalKey<FormFieldState<String>>();

final _formKey = GlobalKey<FormState>();

File pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey, size: 20.0),
        title: Text(
          'add',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ScopedModelDescendant(
        builder: (context, child, MovieController movie){
          return Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    height: MediaQuery.of(context).size.height/4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: pickedImage == null ? AssetImage('assets/logo.png') : FileImage(pickedImage),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.color)
                      ),
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Colors.black,
                      iconSize: 35.0,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                          builder: (BuildContext context){
                            return Container(
                              margin: EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Upload Image',
                                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'camera',
                                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(Icons.camera, color: Color(0xffFFBE01), size: 25.0),
                                    onTap: () {
                                      pickImage(ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'gallery',
                                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(Icons.photo_album, color: Color(0xffFFBE01), size: 25.0),
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        );
                      },
                    ),
                  ),
                  field('Movie Name', TextInputType.text, nameController, nameKey),
                  field('Movie Duration', TextInputType.number, priceController, priceKey),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: FlatButton(
                      child: Text(
                        'add',
                        style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.black,
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () async {
                        if(!_formKey.currentState.validate()){
                          return Scaffold.of(context).showSnackBar(snack('someFieldsRequired'));
                        }else{
                          bool _valid = await movie.addMovie(nameController.text, double.parse(priceController.text));
                          if(_valid == true){
                            return Scaffold.of(context).showSnackBar(snack('movie added'));
                          }else{
                            return Scaffold.of(context).showSnackBar(snack('some thing went wrong'));
                          }
                        }
                      }
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  field(String label, TextInputType inputType, TextEditingController controller, Key key) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.all(10.0),
      elevation: 3.0,
      child: TextFormField(
        key: key,
        validator: (value) {
          if(value.isEmpty){
            return 'this field requred!';
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          labelText: 'label',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal),
        ),
        keyboardType: inputType,
        controller: controller,
      ),
    );
  }
  snack(String content) {
    return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      duration: Duration(seconds: 2),
      content: Text(
        content,
          style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.normal)
      ),
      backgroundColor: Colors.red,
    );
  }
  pickImage(ImageSource source) async {
    var _picked = await ImagePicker.pickImage(source: source);
    if(_picked != null){
      setState(() {
        pickedImage = _picked;
      });
    }else{
      return null;
    }
  }
}