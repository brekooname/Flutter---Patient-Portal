import 'package:flutter/material.dart';
import 'text_field_container.dart';
import 'package:soul/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final controller;
  final IconData icon;
  final errorText;
  final ValueChanged<String>? onChanged;
  final valid;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.errorText,
    this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              validator: valid,
              controller: controller,
              onChanged: onChanged,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                errorText: errorText,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
