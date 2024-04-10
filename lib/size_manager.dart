import 'package:flutter/cupertino.dart';

class SizeManager{
  screenSize(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
}