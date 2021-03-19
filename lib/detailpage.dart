
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'info.dart';

class DetailPage extends StatelessWidget {
  final Map detail;

  DetailPage({Key key, this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Padding( padding: EdgeInsets.only(left: 10, right: 10),child:Html(
          data: detail["body"],
          style: {
            "h4": Style(
              lineHeight: LineHeight(2),
              fontSize: FontSize(20)
            ),
            "li": Style(
              lineHeight: LineHeight(2),
              fontSize: FontSize(18)
            )
          },
        )),
        SizedBox(height: 30.0),
      ],
    );

final topContent = Container(
      child:
      (detail["image"] != null)?
      CachedNetworkImage(
        imageUrl: detail["image"],
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ): Container(),


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

    body: SizedBox ( height: MediaQuery.of(context).size.height, child: new ListView(
      shrinkWrap: true,
      children: <Widget>[
        topContent, topContentText
      ],
    )
));}

}
