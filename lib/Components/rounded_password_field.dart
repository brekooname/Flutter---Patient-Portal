import 'package:flutter/material.dart';
import 'package:soul/components/text_field_container.dart';
import 'package:soul/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final valid;
  final controller;
  final String? hinttext;
  final String? errorText;
  RoundedPasswordField(
      {Key? key,
      this.onChanged,
      this.valid,
      this.controller,
      this.hinttext,
      this.errorText})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool? _passwordVisible;
  @override
  void initState() => _passwordVisible = true;

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
            Icons.lock,
            color: kPrimaryColor,
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              validator: widget.valid,
              controller: widget.controller,
              obscureText: _passwordVisible! ? true : false,
              onChanged: widget.onChanged,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                errorText: widget.errorText,
                hintText: widget.hinttext,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible! ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible!;
                    });
                  },
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
