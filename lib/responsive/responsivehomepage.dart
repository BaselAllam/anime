import 'package:flutter/material.dart';




responsiveHomePageContainer(MediaQueryData data) {

  double _deviceHeight = data.size.height;

  if(_deviceHeight < 550){
    return data.size.height/1.5;
  }else if(_deviceHeight < 750){
    return data.size.height/2;
  }
}



responsiveResultGrid(MediaQueryData data) {

  double _deviceHeight = data.size.height;

  if(_deviceHeight < 550){
    return 0.40;
  }else if(_deviceHeight < 750){
    return 0.55;
  }
}