import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class Cards extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  final Image? image2;
  //final Function press;
  const Cards(
      {Key? key,
      @required this.text1,
      //this.press,
      this.text2,
      this.image2,
      this.text3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 1, offset: Offset(1, 4))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/$text3'),
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                text1!,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: kPrimaryColor.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
