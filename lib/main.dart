import 'package:flutter/material.dart';
import 'package:vexhibition/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'METAVERSE(LMS): VExhibition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        canvasColor: Colors.black,
      ),
      home: Scaffold(body: MainPage(), backgroundColor: Colors.black),
    );
  }
}
