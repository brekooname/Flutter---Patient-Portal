import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class Body extends StatelessWidget {
  final title;
  final child;

  Body({this.title,this.child,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
