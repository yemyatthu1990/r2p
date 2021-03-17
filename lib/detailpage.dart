
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'info.dart';

class DetailPage extends StatelessWidget {
  final Info info;

  DetailPage({Key key, this.info}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.directions_car,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          info.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
      ],
    );

     final bottomContentText = Text(
      "Test",
      style: TextStyle(fontSize: 18.0),
    );

final topContent = Container(
      child:
        Expanded(

          child: CachedNetworkImage(
        imageUrl: info.pictureUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
        ),

    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text("Detail"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

     return Scaffold(
       appBar: topAppBar,
      body: ListView(
        children: noteWidgets(topContent,info.notes),
      ),
    );
  }

  List<Widget> noteWidgets(Widget topContent, List<String> notes) {
    //
    List<Widget> noteWidgets = new List();
    noteWidgets.add(topContent);
    print(notes.length);
    for (var i=0; i< notes.length; i++) {
      print(i);
      print(notes[i]);
      noteWidgets.add(ListTile(
        leading: Icon(Icons.fiber_manual_record),
        title: Text(notes[i]),
      ));
    }
    return noteWidgets;
  }
}
