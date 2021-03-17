import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Container makeBody() => Container(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
           itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.amber,
          child: Center(child: Text('$index')),
        );
      }
      )
    );
  @override
  Widget build(BuildContext context) {
    return makeBody();
    }
}
  
