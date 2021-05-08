import 'package:flutter/widgets.dart';

class ImageCard extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _ImageCardState extends State<ImageCard> {
  String imageUrl = "";

  void _updateImageUrl(String url) {
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}