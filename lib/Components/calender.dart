import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:soul/constants.dart';

class Doctorcalender extends StatelessWidget {
  final DateTime? date;
  final List<String>? times;
  final String? name;
  final String? drop;
  final void Function(String?)? change; // Updated type here
  final String? hint;
  const Doctorcalender(
      {Key? key,
      this.date,
      this.times,
      this.name,
      this.drop,
      this.change,
      this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (date == null) return Container();

    return Card(
      elevation: 4, // Slight shadow for depth
      shadowColor: kPrimaryColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Smooth rounded corners
      ),
      margin: const EdgeInsets.all(8.0), // Margins around the card
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: DropdownSearch<String>(
          items: times,
          mode: Mode.MENU,
          showSelectedItems: true,
          selectedItem: drop,
          dropdownSearchDecoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder( // Rounded border for input
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            filled: true, // Filled color
            fillColor: Colors.grey.shade200, // Light grey fill
            contentPadding: EdgeInsets.all(10), // Padding inside the dropdown
          ),
          validator: (String? item) {
            if (item == null) return "Required field";
            else return null;
          },
          onChanged: change,
          // Apply any additional styling as required
        ),
      ),
    );
  }
 }
