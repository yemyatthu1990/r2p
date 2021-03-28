import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  FullScreenImage({Key? key,required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(
                  imageUrl
              ),
            )
        )
    );
  }

}