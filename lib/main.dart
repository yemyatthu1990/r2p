import 'package:flutter/material.dart';
import 'package:myanmar_emergency/categorypage.dart';
import 'package:myanmar_emergency/info.dart';

import 'listpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Emergency Guide',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: new CategoryPage(),
    );
  }
}
