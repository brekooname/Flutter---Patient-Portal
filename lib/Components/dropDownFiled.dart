import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../constants.dart';

class DropDown extends StatelessWidget {
  final List<String>? list;
  final value1;
  final String? v;
  final void Function(String?)? onChanged1;
//  final Function tap;
  final String? hint;
  const DropDown(
      {Key? key,
      @required this.list,
      this.onChanged1,
      this.value1,
      this.hint,
      this.v})
      : super(key: key);

  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);

    return Container(    padding: EdgeInsets.symmetric(vertical: 10),

      child: Card(
        shadowColor: kPrimaryColor,
        shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xFF056195)),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: DropdownSearch<String>(
            items: list,
            mode: Mode.MENU,
            showSelectedItems: true,
            selectedItem: v,
            dropdownSearchDecoration: InputDecoration(
              labelText: hint,
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(15.0),
              //   borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.5)),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(15.0),
              //   borderSide: BorderSide(color: Colors.grey[300]!),
              // ),
              hintStyle: TextStyle(color: Colors.grey.shade500),
            ),
            validator: (String? item) {
              if (item == null) return "Required field";
              else return null;
            },
            onChanged: onChanged1,
          ),
        ),
       // onTap: () {},
      ),
    );
  }

}
