import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class BookAppointmentTab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 5,
          children: [
            _clinicName(),
            _richText("Address : ",
                "210 Street, Health City Behind walMart, New York, USA"),
            _richText("Phone : ", "+212123456789"),
            _infoBtnS()
          ],
        ),
      ),
    );
  }

  Widget _clinicName() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        "Life Plus Clinic",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }

  Widget _richText(String label, String content) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 18),
          children: <TextSpan>[
            TextSpan(
                text: content,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 15,
                    height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _infoBtnS() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
              child: elevatedButton(
                  text: "Call",
                  color: kPrimaryColor,
                  onPress: () {},
                  textSize: 15,
                  fontWeight: FontWeight.w500,
                  compactSize: true)),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: elevatedButton(
                text: "Directions",
                color: kPrimaryColor,
                onPress: () {},
                textSize: 15,
                fontWeight: FontWeight.w500,
                compactSize: true),
          )),
          Expanded(
              child: elevatedButton(
                  text: "Website",
                  color: kPrimaryColor,
                  onPress: () {},
                  textSize: 15,
                  fontWeight: FontWeight.w500,
                  compactSize: true))
        ],
      ),
    );
  }

  ElevatedButton elevatedButton(
          {@required String? text,
          @required Color? color,
          @required Function? onPress,
          Color textColor = Colors.white,
          double textSize = 18,
          FontWeight fontWeight = FontWeight.w500,
          bool compactSize = false}) =>
      ElevatedButton(
          onPressed: () => {onPress!.call()},
          child: Text(
            text!,
            style: TextStyle(
                fontSize: textSize, color: textColor, fontWeight: fontWeight),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color!),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: compactSize ? 0 : 14)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)))));
}
