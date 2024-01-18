import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

import '../sizeConfig.dart';

class ServiceCard extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  final void Function()? press; //final Function press;
  const ServiceCard(
      {Key? key,
      @required this.text1,
      //this.press,
      this.text2,
      this.text3,
      this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.safeBlockVertical! * 14,
        width: SizeConfig.safeBlockHorizontal! * 42,
        decoration: BoxDecoration(
          color: Colors.white, // Neumorphic style prefers a light color
          borderRadius: BorderRadius.circular(15), // Softer rounded corners
          boxShadow: [
            // Neumorphic shadows
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            // BoxShadow(
            //   color: Colors.grey.shade500,
            //   offset: Offset(6.0, 6.0),
            //   blurRadius: 16.0,
            // ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/$text3',
                height: SizeConfig.safeBlockVertical! * 6,
              ),
              SizedBox(height: 8),
              Text(
                text1!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black, // Using a darker color for text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
