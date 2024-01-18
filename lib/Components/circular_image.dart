import 'package:flutter/material.dart';

class CirculerImage extends StatelessWidget {
  final String? imageName;
  final width;
  final height;

  CirculerImage({this.imageName, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
        image: DecorationImage(
          image: ExactAssetImage('assets/images/$imageName'),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
      ),
    );
  }
}
