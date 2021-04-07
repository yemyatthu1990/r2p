// @dart=2.9
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_emergency/categorypage.dart';
import 'package:myanmar_emergency/image_database.dart';

import 'appdatabase.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final  appDatabase = await $FloorAppDatabase.databaseBuilder(
      "app_database.db").build();

  final categoryDao = appDatabase.categoryDao;
  final subCategoryDao = appDatabase.subCategoryDao;
  final detailDao = appDatabase.detailDao;
  try {
    runApp(MaterialApp(
      title: 'R2P',
      home: CategoryPage(categoryDao: categoryDao, subCategoryDao: subCategoryDao, detailDao: detailDao),
    ));
  } on  Exception catch(_) {
    print("error");
  }


}


