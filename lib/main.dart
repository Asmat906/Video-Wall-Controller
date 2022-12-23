import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_wall_controller/video_screen.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    // ignore: prefer_const_constructors
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
  ));
  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideosList(),
    ),
    
  );
}

