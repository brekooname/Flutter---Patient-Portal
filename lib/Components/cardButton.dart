import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class CardButton extends StatelessWidget {
  final String? text;
  final void Function()? press;
  const CardButton({
    Key? key,
    @required this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.2,
      height: size.height * 0.04,
      child: ClipRRect(
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
