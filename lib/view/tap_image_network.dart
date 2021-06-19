
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapImageNetwork extends StatelessWidget {
  const TapImageNetwork({ required Key key, required this.photo, required this.onTap, required this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}