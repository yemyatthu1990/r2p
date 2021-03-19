import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'listpage.dart';

class CategoryPage extends StatefulWidget {
    final FirebaseApp app;
  const CategoryPage({Key key, this.app}) : super(key: key); //
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  DatabaseReference _categoryRef;
  DatabaseReference _subcategoryRef;
  DatabaseReference _detailRef;
  List<Object> categories;
  Map details;
  Map subcategories;

   void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _categoryRef =database.reference().child('category');
    _subcategoryRef = database.reference().child("subcategories");
    _detailRef = database.reference().child("detail");
    _categoryRef.once().then((DataSnapshot snapshot) {
      setState(() {
        categories = snapshot.value;
      });
    });
    _subcategoryRef.once().then((DataSnapshot snapshot) {
      subcategories = snapshot.value;
    });
    _detailRef.once().then((DataSnapshot snapshot) {
      details = snapshot.value;
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _categoryRef.keepSynced(true);
  }
  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Colors.red,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );
  Container makeBody(BuildContext context) => Container(
    color: Colors.white,
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height/(4/0.75), 20, 0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: categories != null? categories.length: 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
      ),
           itemBuilder: (BuildContext context, int index) {
          Map category = categories[index] as Map;
          Map detail = details[category["id"]];
          List<Object> subcat = subcategories[category["id"]] as List<Object>;
        return Card(
          color: Colors.red,
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListPage(title: category["name"], subCat: subcat, detail: detail, )));
              },
              child: Center(child: Text(category["name"], style: TextStyle(fontSize: 20, color: Colors.white),))),
        );
      }
      )
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar,
      body: makeBody(context),
    );
    }
}
  
