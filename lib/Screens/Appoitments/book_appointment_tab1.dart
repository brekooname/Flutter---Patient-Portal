import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class BookAppointmentTab1 extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _text(
            "Education",
            bottom: 10,
          ),
          _bulletsText('UCL - Cliniques Saint - Luc (1987 -1999)- Docteur'),
          _bulletsText(
              'UCL - Cardiologue. Recherche au Laboratoire d’échocardiographie.'),
          _bulletsText('ULG-CHU Start-Tilman (1999-2000). Recherche',
              bottom: 10),
          Divider(height: 0.8, color: kPrimaryColor.withOpacity(0.2)),
          _text("Publications", bottom: 10, top: 10),
          _bulletsText(
              "Electrocardiograms Findings - Lebrun F, Blouard Ph, Ch Brohe Quotation of functional mitral regurgitation during bicycle exercise in patients with heart failure. 1998",
              bottom: 10),
          Divider(height: 0.8, color: kPrimaryColor.withOpacity(0.2)),
          _text(
            "Description",
            top: 10,
            bottom: 10,
          ),
          _bulletsText(
              'Electrocardiograms Findings - Lebrun F, Blouard Ph, Ch Brohe Quotation of functional mitral regurgitation during bicycle exercise in patients with heart failure. 1998'),
        ],
      ),
    );
  }

  Widget _text(String text, {double top = 0, double bottom = 0}) {
    return Container(
      margin: EdgeInsets.only(top: top, bottom: bottom),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _bulletsText(String text, {double top = 0, double bottom = 0}) {
    return Container(
      margin: EdgeInsets.only(top: top, bottom: bottom),
      child: RichText(
        text: TextSpan(
          text: '• ',
          style: TextStyle(
              color: kPrimaryColor.withOpacity(0.5), fontSize: 18),
          children: <TextSpan>[
            TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 15,
                    height: 1.5)),
          ],
        ),
      ),
    );
  }
}
