import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapImageLocal extends StatelessWidget {
  const TapImageLocal(
      {required Key key,
      required this.photo,
      required this.onTap,
      required this.width})
      : super(key: key);

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
            child: Image.file(
              File(photo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
