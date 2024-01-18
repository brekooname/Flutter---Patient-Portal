import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class insuranceCon extends StatelessWidget {
  final String? text1;
  final String? text2;

  //final Function press;
  const insuranceCon({
    Key? key,
    @required this.text1,
    //this.press,
    this.text2,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF056195),
              width: 1.5,
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomLeft,
              child: _textLabel2(text1!),
            ),
            SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomLeft,
              child: _textLabel(text2!),
            ),
          ],
        ),
      ),
    );
  }


  Widget _textLabel(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 17.0, color: Colors.white54));

  Widget _textLabel2(String label) => Text(label,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ));
}
