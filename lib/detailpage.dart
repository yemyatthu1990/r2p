import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:myanmar_emergency/detail.dart';
import 'package:myanmar_emergency/fullscreenimage.dart';

import 'info.dart';

class DetailPage extends StatelessWidget {
  final Detail detail;
  final String title;
  final String imagePath;
  DetailPage({Key? key, required this.title,required this.detail, required this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Padding( padding: EdgeInsets.only(left: 10, right: 10),child:Html(
          data: detail.body,
          style: {
            "h4": Style(
              lineHeight: LineHeight(2),
              fontSize: FontSize(20)
            ),
            "li": Style(
              lineHeight: LineHeight(2),
              fontSize: FontSize(18)
            ),
            "p": Style(
              lineHeight: LineHeight(2),
                fontSize: FontSize(18)
            )
          },
        )),
        SizedBox(height: 30.0),
      ],
    );

final topContent = Container(
      child: InkWell (
      onTap: (){
        if ((detail.image != null && (detail.image as String).length > 0)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScreenImage(imageUrl:detail.image, )));
        }
      },
          child: (detail.image != null && (detail.image as String).length > 0)?
              Image.file(File(imagePath)): Container()),
     //  CachedNetworkImage(
     //    imageUrl: detail.image,
     //    placeholder: (context, url) => Center( child: Padding( padding: EdgeInsets.all(10), child:SizedBox(width: 50, height: 50,child:CircularProgressIndicator()))),
     //    errorWidget: (context, url, error) => Icon(Icons.error),
     // ): Container()),


    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.red,
      title: Text(title),
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
