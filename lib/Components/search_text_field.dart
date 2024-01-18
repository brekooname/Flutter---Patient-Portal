import 'package:flutter/material.dart';
import 'package:soul/constants.dart';
class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: kPrimaryLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
            autofocus: false,
            style: TextStyle(color: kPrimaryLightColor, fontSize: 18),
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search_outlined,
                  color: Colors.black.withOpacity(0.3),
                ),
                contentPadding:
                EdgeInsets.only(left: 5, bottom: 16, top: 16, right: 15),
                hintStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.3)),
                hintText: 'Search')
                ),
      ),
    );
  }
}
