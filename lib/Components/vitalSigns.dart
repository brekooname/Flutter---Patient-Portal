import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class VitalS extends StatelessWidget {
  final String? text1;
  final String? text2;

  //final Function press;
  const VitalS(
      {Key? key,
      @required this.text1,
      //this.press,
      this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible( // Wrap with Flexible
          child: Align(
            alignment: Alignment.bottomLeft,
            child: _textLabel2(text1!),
          ),
        ),
        SizedBox(height: 2),
        Flexible( // Wrap with Flexible
          child: Align(
            alignment: Alignment.bottomLeft,
            child: _textLabel(text2!),
          ),
        ),
      ],
    );
  }

  Widget _textLabel(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 17.0, color: kPrimaryColor));

  Widget _textLabel2(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(overflow: TextOverflow.ellipsis,
        fontSize: 20.0,
        color: Colors.black,
      ));
}
