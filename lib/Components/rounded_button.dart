import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

import '../sizeConfig.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final void Function()? press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.color = kPrimaryLightColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: SizeConfig.safeBlockHorizontal! * 30,
      height: SizeConfig.safeBlockVertical! * 7,
      child: ClipRRect(
        //borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            backgroundColor: color,
          ),
          onPressed: press,
          child: Text(
            text!,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
