import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_emergency/categorypage.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


    final FirebaseApp app = await Firebase.initializeApp(
      name: 'db2',
      options: Platform.isIOS || Platform.isMacOS
          ? const FirebaseOptions(
        appId: '1:297855924061:ios:c6de2b69b03a5be8',
        apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
        projectId: 'flutter-firebase-plugins',
        messagingSenderId: '297855924061',
        databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
      )
          : const FirebaseOptions(
          appId: '1:331181411235:android:4ee914ef3259d973b7a816',
          apiKey: 'AIzaSyBPRjqGImBOUAYugRlB4BxAamo9gA6Rsi0',
          messagingSenderId: '331181411235',
          projectId: 'myanmar-emergency',
          storageBucket: "myanmar-emergency.appspot.com",
          databaseURL: 'https://myanmar-emergency-default-rtdb.firebaseio.com'
      ),
    );

  runApp(MaterialApp(
    title: 'Flutter Database Example',
    home: CategoryPage(app: app),
  ));
}


class MyHomePage extends StatelessWidget {
  final FirebaseApp app;
  const MyHomePage({Key key, this.app}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Emergency Guide',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: new CategoryPage(app: app),
    );
  }
}
