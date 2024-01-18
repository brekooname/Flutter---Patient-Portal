import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class RoundedRectContainer extends StatelessWidget {
  final String? text;
  final onTap;
  const RoundedRectContainer({
    Key? key,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.4,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Expanded(
            child: Text(
              text!,
              style: TextStyle(
                  fontSize: 18.0, wordSpacing: 2.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
