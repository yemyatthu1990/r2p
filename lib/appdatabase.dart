// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:myanmar_emergency/detail.dart';
import 'package:myanmar_emergency/sub_category.dart';
import 'package:myanmar_emergency/sub_category_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'category.dart';
import 'category_dao.dart';
import 'detail_dao.dart';
part 'appdatabase.g.dart';
@Database(version: 2, entities: [Category, SubCategory, Detail])
abstract class AppDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
  SubCategoryDao get subCategoryDao;
  DetailDao get detailDao;
}