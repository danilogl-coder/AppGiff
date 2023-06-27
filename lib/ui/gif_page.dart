import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  const GifPage({super.key, required this.gifData});
  final Map gifData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gifData['title']),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body:
          Center(child: Image.network(gifData['media_formats']['gif']['url'])),
    );
  }
}
