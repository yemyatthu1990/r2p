// @dart=2.9
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myanmar_emergency/categorypage.dart';

import 'appdatabase.dart';


FirebaseApp app;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark)
  );
  final  appDatabase = await $FloorAppDatabase.databaseBuilder(
      "app_database.db").build();

  final categoryDao = appDatabase.categoryDao;
  final subCategoryDao = appDatabase.subCategoryDao;
  final detailDao = appDatabase.detailDao;
  try{
    app = await Firebase.initializeApp(
      name: 'db2',
      options: Platform.isIOS || Platform.isMacOS
          ? const FirebaseOptions(
        appId: '1:331181411235:ios:7e2a873fde389398b7a816',
        apiKey: 'AIzaSyB0_9wk2R6F-Geyv2CNyVNS5skCiZWWEnE',
        projectId: 'myanmar-emergency',
        messagingSenderId: '331181411235',
        databaseURL: 'https://myanmar-emergency-default-rtdb.firebaseio.com',
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
  } catch (e){
      app = Firebase.app('db2');
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SRF21',
    home: CategoryPage( app: app, categoryDao: categoryDao, subCategoryDao: subCategoryDao, detailDao: detailDao),
  ));
}



