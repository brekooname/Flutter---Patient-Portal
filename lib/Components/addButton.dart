import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

import '../sizeConfig.dart';

class AddButton extends StatelessWidget {
  final String? text;
  final void Function()? press;

  const AddButton({
    Key? key,
    @required this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: SizeConfig.safeBlockHorizontal! * 30,
      height: SizeConfig.safeBlockVertical! * 7,
      child: ClipRRect(
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            backgroundColor: kPrimaryLightColor,
          ),
          onPressed: press,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
