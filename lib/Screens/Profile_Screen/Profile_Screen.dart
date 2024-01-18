import 'package:flutter/material.dart';
import 'package:soul/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:soul/Components/circular_image.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? currentUser, name, ph, birthday, e, pHeight, pWeight, blood;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWithBack(context, isProfileIconEnabled: false),
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _firstSection(),
                  _informationSectionWithTitle("PERSONAL INFORMATION", [
                    _textFieldWithLabel("Birthday", birthday ?? "Not Set"),
                    _textFieldWithLabel("Language", "English"),
                    _textFieldWithLabel("Mobile Number", ph ?? "Not Set"),
                    _textFieldWithLabel('Email', e ?? "Not Set"),
                  ]),
                ]),
          ),
        ),
      ),
    );

  }

  Container _firstSection() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    decoration: BoxDecoration(
      color: Color(0xFF056195).withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CirculerImage(
          imageName: 'profile.png',
          width: 140.0,
          height: 140.0,
        ),
        SizedBox(height: 20),
        Text(
          '$name',
          style: TextStyle(
            fontSize: 30,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        _highLightedSquares(),
      ],
    ),
  );
  Row _highLightedSquares() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _highlightedSquare(blood ?? "N/A", "Blood Type"),
      _highlightedSquare(pHeight ?? "N/A", "Height"),
      _highlightedSquare(pWeight ?? "N/A", "Weight"),
    ],
  );

  Expanded _highlightedSquare(String title, String subtitle) => Expanded(
          child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF056195).withOpacity(0.1),
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor.withOpacity(1),
                    fontWeight: FontWeight.bold)),
            Text(subtitle,
                style: TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor.withOpacity(0.5),
                    fontWeight: FontWeight.bold))
          ],
        ),
      ));

  Container _informationSectionWithTitle(String title, List<Widget> children) =>
      Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF056195).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: kPrimaryColor.withOpacity(0.9),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15),
            ...children,
          ],
        ),
      );
  Widget _textFieldWithLabel(String label, String value) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

  PreferredSizeWidget appbarWithBack(BuildContext context, {bool isProfileIconEnabled = true}) =>
      AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,size: 30,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          if (isProfileIconEnabled)
            IconButton(
              icon: Image.asset(
                'assets/images/profile.png',
                height: 25,
              ),
              onPressed: () => context.navigateToScreen(Profile()),
            ),
          SizedBox(width: isProfileIconEnabled ? 8 : 0),
        ],
      );

}

extension navigateScreen on BuildContext {
  navigateToScreen(StatefulWidget widget) {
    Navigator.of(this).push(CupertinoPageRoute(builder: (context) => widget));
  }
}
