
import 'package:flutter/material.dart';

import '../constants.dart';
import '../sizeConfig.dart';

class AppointmentCard extends StatefulWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  final color;

  final Widget? app;

  //final Function press;
  const AppointmentCard(
      {Key? key,
      @required this.text1,
      //this.press,
      this.text2,
      this.text3,
      this.app,
      this.color});

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

@override
class _AppointmentCardState extends State<AppointmentCard> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.app!),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        alignment: Alignment.center,
        height: SizeConfig.safeBlockVertical! * 14,
        width: SizeConfig.safeBlockHorizontal! * 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/${widget.text3}',
                height: SizeConfig.safeBlockVertical! * 6,
              ),
              SizedBox(height: 8),
              Text(
                widget.text1!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}