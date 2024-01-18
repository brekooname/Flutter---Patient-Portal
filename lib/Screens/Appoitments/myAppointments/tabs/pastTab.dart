import 'package:flutter/material.dart';
import 'package:soul/Screens/Appoitments/commonListItem.dart';

class PastTab extends StatelessWidget {
  List<CommonListItem>? past;
  PastTab({@required this.past});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: past!.length,
        // The list items
        itemBuilder: (context, index) {
          return Container(
            child: past![index],
          );
        },
      ),
    );
  }
}
