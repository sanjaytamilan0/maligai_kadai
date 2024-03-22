import 'dart:ui';

import 'package:flutter/material.dart';

class WebCustomScrollView extends MaterialScrollBehavior{
  @override
  Set<PointerDeviceKind> get dragDevices =>{
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch
  };
}