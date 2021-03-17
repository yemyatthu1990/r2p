import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'listpage.dart';
import 'listpage.dart';

class CategoryPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
        itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
      ),
           itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.red,
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListPage(title: "First Aid",)));
              },
              child: Center(child: Text('First Aid', style: TextStyle(fontSize: 20, color: Colors.white),))),
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
  
