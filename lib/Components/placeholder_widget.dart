import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final Widget bod;

  PlaceholderWidget(@required this.bod);

  @override
  Widget build(BuildContext context) {
    return bod;
  }
}