import 'package:appgiff/ui/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AppGif",
      home: HomePage(),
      theme: ThemeData(hintColor: Colors.white),
    ),
  );
}
