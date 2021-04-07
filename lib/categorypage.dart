import 'dart:convert';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:myanmar_emergency/category.dart';
import 'package:myanmar_emergency/category_dao.dart';
import 'package:myanmar_emergency/detail.dart';
import 'package:myanmar_emergency/sub_category.dart';
import 'package:myanmar_emergency/sub_category_dao.dart';

import 'appdatabase.dart';
import 'detail_dao.dart';
import 'listpage.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key, required this.categoryDao, required this.subCategoryDao, required this.detailDao}) : super(key: key);
  final CategoryDao categoryDao;
  final SubCategoryDao subCategoryDao;
  final DetailDao detailDao;
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  DatabaseReference? _categoryRef;
  DatabaseReference? _subcategoryRef;
  DatabaseReference? _detailRef;
  bool detailDownloaded = false;
  bool subCatDownloaded =false;
  bool imagesDownloaded = false;
  Future<bool> downloadAllImages(List<String> imageUrls) async {
    for (var url in imageUrls) {
      try {
        await ImageDownloader.downloadImage(url, destination: AndroidDestinationType.custom(directory: "cache")
        ..subDirectory(url)
          ..inExternalFilesDir()
        );
      } catch (error) {
        print(error);
      }
    }
    return true;
  }
    void initState() {
    super.initState();

    final FirebaseDatabase database = FirebaseDatabase.instance;

        _categoryRef =database.reference().child('category');
        _subcategoryRef = database.reference().child("subcategories");
        _detailRef = database.reference().child("detail");
        
        _categoryRef?.once().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            widget.categoryDao.deleteAll();
          }
          (snapshot.value as List<Object>).forEach((element) {
            var cat = new Category((element as Map)["id"], (element)["name"]);
            widget.categoryDao.insertCategory(cat);
          });
        });
        _subcategoryRef?.once().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            widget.subCategoryDao.deleteAll();
          }
          (snapshot.value as Map).forEach((key, value) {
            List<Object> subcatObjs = value;
            subcatObjs.forEach((element) {

              if (element != null) {
                var subcatMap = (element as Map);
                SubCategory subCategory = new SubCategory(
                    subcatMap["id"], subcatMap["icon"], subcatMap["name"], key);
                widget.subCategoryDao.insertSubCategory(subCategory);
              }

            });
            setState(() {
              subCatDownloaded = true;
            });

          });
        });
        List<String> urls = [];
        _detailRef?.once().then((DataSnapshot snapshot) {
          (snapshot.value as Map).forEach((key, value) {
            String catId = key;
            Map subCatDetailMap = value;
            subCatDetailMap.forEach((subKey, subValue) {
              Map subValueMap = subValue;
              Detail detail = new Detail(subValueMap["id"], catId+subKey,subValueMap["image"], subValueMap["body"]);
              widget.detailDao.insertDetail(detail);
              print("url: "+detail.image);
              if (detail.image.isNotEmpty) {
                urls.add(detail.image);
              }
            });
            downloadAllImages(urls)
            .then((value) => {
              if (value) setState(() {
                imagesDownloaded = true;
              })
            });
          });
        });

    }

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Colors.blue,
    title: Text("R2P"),
  );
  Container makeBody(BuildContext context) => Container(
    color: Colors.white,
      child: StreamBuilder<List<Category>> ( stream: widget.categoryDao.getAllCategoriesAsStream(), builder: (_, snapshot) {
  if (!imagesDownloaded) return Center(child: Text("အင်တာနက် မလိုဘဲ အသုံးပြုနိုင်ရန်\n ပြင်ဆင်နေပါသည်။", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,));
  else {
  final data = snapshot.requireData;
  return GridView.builder(
        padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height/(4/0.75), 20, 0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
      ),
           itemBuilder: (BuildContext context, int index) {
             Category? category;
             category = data.elementAt(index);
        return Card(
          color: Colors.blue,
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListPage(title: category?.name ?? "R2P",catId: category?.id ?? "", subCategoryDao: widget.subCategoryDao, detailDao: widget.detailDao, )));
              },
              child: Center(child: Text( category.name, style: TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center))),
        );
      }
      );}})
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar,
      body: (makeBody(context) ),
    );
    }
}
  
