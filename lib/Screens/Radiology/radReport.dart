import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:soul/constants.dart';



class RadReport extends StatelessWidget {
  final Html? text;
  const RadReport({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF1FA),

      // appBar: appBar(_scaffoldKey, context),S
      body: SafeArea(
        child: Column(
          children: [
            toolbarView("Report"),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 5,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: text,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
      //drawer: CustomDrawer()
    );
  }

  Widget toolbarView(String label) => Container(
      height: 60.0,
      padding: EdgeInsets.only(left: 160, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: TextStyle(
              color: kPrimaryColor, fontSize: 22, fontWeight: FontWeight.w600)),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2),
              offset: const Offset(0, 1.0),
              blurRadius: 4.0,
              spreadRadius: 2.0,
            ),
          ]));
}
