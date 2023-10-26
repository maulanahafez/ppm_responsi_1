import 'package:flutter/material.dart';
import 'package:ppm_responsi_1/ui/ikan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const IkanPage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ikan',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
