import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul/Components/tableViews.dart';
import 'package:soul/Entities/CaregoryLabResults.dart';

import '../constants.dart';

class Expansionpanel extends StatefulWidget {
  Expansionpaneltate createState() => Expansionpaneltate();

  final List<CaregoryLabResults> Results;
  Expansionpanel(this.Results);
}

class NewItem {
  final prefs = SharedPreferences.getInstance();
  bool isExpanded;
  final String header;
  final Widget body;

  NewItem(
    this.isExpanded,
    this.header,
    this.body,
    Radio<Null> radio,
  );
}

class Expansionpaneltate extends State<Expansionpanel> {
  List<NewItem> items = [];
  // for loop to fill the list of items

  List<NewItem> getitems() {
    print("panel" + widget.Results.toString());
    for (CaregoryLabResults category in widget.Results) {
      //List<NewItem> items = <NewItem>[
      NewItem item = NewItem(
        false, // isExpanded ?
        // category
        category.CategoryName!, // header
        Padding(
          padding: EdgeInsets.all(5.0),
          child: TableViews(
            result: category.OrdersList,
          ),
        ),
        Radio(value: null, groupValue: null, onChanged: null),
      ); // body

      items.add(item);
      print(category.OrdersList!.first.orderDate);
      //];
    }
    return items;
  }

  @override
  void initState() {
    getitems();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            elevation: 2,
            expandedHeaderPadding: EdgeInsets.all(10),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    leading: Image.asset('assets/images/icons8-test-results-60.png', color: kPrimaryColor, width: 24.0, height: 24.0),
                    title: Text(
                      item.header,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                    ),
                  );
                },
                isExpanded: item.isExpanded,
                body: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: item.body,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
