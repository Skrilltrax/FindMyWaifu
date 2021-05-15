import 'package:flutter/material.dart';

Widget SingleCard(String url) {

  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))),
    margin: EdgeInsets.symmetric(vertical: 64, horizontal: 32),
    child: Image.network(
      url,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    ),
  );
}
