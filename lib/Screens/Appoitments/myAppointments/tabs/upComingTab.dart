import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul/Screens/Appoitments/commonListItem.dart';

class UpComingTab extends StatelessWidget {
  final Future<List<CommonListItem>> upCommingFuture;

  const UpComingTab({Key? key, required this.upCommingFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: FutureBuilder<List<CommonListItem>>(
        future: upCommingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error if any
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Upcoming Appointments')); // Show message when no data is available
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  child: snapshot.data![index],
                );
              },
            );
          }
        },
      ),
    );
  }
}

 

 
  
  // void _show(BuildContext ctx) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       elevation: 5,
  //       context: ctx,
  //       builder: (ctx) => Padding(
  //             padding: EdgeInsets.only(
  //                 top: 15,
  //                 left: 15,
  //                 right: 15,
  //                bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
  //             // child: Column(
  //             //   mainAxisSize: MainAxisSize.min,
  //             //   crossAxisAlignment: CrossAxisAlignment.start,
  //             //   children: [
  //             //     const TextField(
  //             //       keyboardType: TextInputType.name,
  //             //       decoration: InputDecoration(labelText: 'Name'),
  //             //     ),
  //             //     const TextField(
  //             //       keyboardType: TextInputType.number,
  //             //       decoration: InputDecoration(labelText: 'Age'),
  //             //     ),
  //             //     const SizedBox(
  //             //       height: 15,
  //             //     ),
  //             //     ElevatedButton(onPressed: () {}, child: const Text('Submit'))
  //             //   ],
  //             // ),
  //             child: Wrap(
  //                   crossAxisAlignment: WrapCrossAlignment.center,
  //                   runSpacing: 5,
  //                   children: [
  //                     //_searchSpeciality(),
  //                     DropDown(list: clinics,value1: clinic,hint: "Clinic" ,onChanged1: (x){
  //                       clinic=x;
  //                     },),
  //                     //_searchOne(),
  //                    DropDown(list: doctors,value1: doctor,
  //                 hint: "Doctors",onChanged1: (x){
  //                       doctor=x;
  //                       print("doctooor "+doctor);
  //                     }),
  //                     _searchThree(),
  //                       Doctorcalender(name: doctor,),
  //                     _searchBtn(),
                     
  //                   ])));
  // } 
  //  Widget _searchOne() => textField(
  //       'doctors', Icons.search, _searchDocController,

  //       // //onChanged: (value) {

  //       //             },
  //       // onTap: (){
  //     );
  // Widget _searchSpeciality() => textField(
  //       'Clinic', Icons.search, _searchClinicController,

  //       //onChanged: (){}
  //     );
  // static List<String> doctors = [
  //   "Omar",
  //   "Ahmad",
  //   "Banana",
  //   "Sama",
  //   "Sondoss",
  //   "yousef",
    
  // ];
  //  static List<String> clinics = [
  //   "general",
  //   "pediatric",
  //   "Antental ",
   
    
  // ];

  // // Widget _searchTow() => textField('Select area',
  // //     Icons.location_on_outlined, _searchAreaController);
  // Widget textField(String hint, IconData iconData,
  //         TextEditingController textEditingController,
  //         {bool isReadonly = false,
          
  //         Function onTap,
  //         int minLines = 1}) =>
  //     Card(
  //       elevation: 3,
  //       shadowColor: kPrimaryColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       child: TextField(
  //           autofocus: false,
            
  //           onTap: () {
  //             if (onTap != null) onTap.call();
  //           },
  //           minLines: minLines,
  //           maxLines: null,
  //           controller: textEditingController,
  //           showCursor: !isReadonly,
  //           readOnly: isReadonly,
  //           style: TextStyle(color: kPrimaryColor, fontSize: 18),
  //           decoration: new InputDecoration(
  //               border: InputBorder.none,
  //               focusedBorder: InputBorder.none,
  //               enabledBorder: InputBorder.none,
  //               errorBorder: InputBorder.none,
  //               disabledBorder: InputBorder.none,
  //               prefixIcon: iconData != null
  //                   ? IconButton(
  //                       icon: Icon(
  //                         iconData,
  //                         color: kPrimaryColor,
  //                       ),
  //                       onPressed: () {},
  //                     )
  //                   : null,
  //               contentPadding:
  //                   EdgeInsets.only(left: 10, bottom: 12, top: 12, right: 10),
  //               hintStyle: TextStyle(
  //                   fontSize: 18.0,
  //                   fontWeight: FontWeight.w300,
  //                   color: Colors.black.withOpacity(0.5)),
  //               hintText: hint)),
  //     );
  // Widget _searchThree() =>
  //     textField('Select date', Icons.date_range, _dateController,
  //         isReadonly: true, onTap: () {
  //       final ThemeData theme = Theme.of(context);
  //       if (theme.platform == TargetPlatform.android)
  //         _openDatePicker();
  //       else
  //         _openDatePickerIOS();
  //     });

  // Widget _searchBtn() => Container(
  //       margin: EdgeInsets.only(top: 5),
  //       width: MediaQuery.of(context).size.width,
  //       child: elevatedButton(
  //           text: 'Book',
  //           fontWeight: FontWeight.w500,
  //           color: kPrimaryColor,
  //           onPress: () {
             
  //           }),
  //     );

  // void _openDatePicker() async {
  //   final DateTime result = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );
  //   if (result != null && result != _selectedDate)
  //     setState(() {
  //       _selectedDate = result;
  //       _dateController.text = dateFormat(_selectedDate);
  //     });
  // }

  // String dateFormat(DateTime dateTime) {
  //   final DateFormat formatter = DateFormat('dd MMM yyyy');
  //   final String formatted = formatter.format(dateTime);
  //   return formatted;
  // }

  // ElevatedButton elevatedButton(
  //         {@required String text,
  //         @required Color color,
  //         @required Function onPress,
  //         Color textColor = Colors.white,
  //         double textSize = 18,
  //         FontWeight fontWeight = FontWeight.w500,
  //         bool compactSize = false}) =>
  //     ElevatedButton(
  //         onPressed: () => {onPress.call()},
  //         child: Text(
  //           text,
  //           style: TextStyle(
  //               fontSize: textSize, color: textColor, fontWeight: fontWeight),
  //         ),
  //         style: ButtonStyle(
  //             backgroundColor: MaterialStateProperty.all<Color>(color),
  //             padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
  //                 EdgeInsets.symmetric(vertical: compactSize ? 0 : 14)),
  //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                 RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(8.0)))));

  // void _openDatePickerIOS() async {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext builder) {
  //         return Container(
  //           height: MediaQuery.of(context).copyWith().size.height / 3,
  //           color: Colors.white,
  //           child: CupertinoDatePicker(
  //             mode: CupertinoDatePickerMode.date,
  //             onDateTimeChanged: (result) {
  //               if (result != null && result != _selectedDate)
  //                 setState(() {
  //                   _selectedDate = result;
  //                   _dateController.text = dateFormat(_selectedDate);
  //                 });
  //             },
  //             initialDateTime: _selectedDate,
  //             minimumYear: 2000,
  //             maximumYear: 2025,
  //           ),
  //         );
  //       });

  //   final DateTime result = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );
  //   if (result != null && result != _selectedDate)
  //     setState(() {
  //       _selectedDate = result;
  //       _dateController.text = dateFormat(_selectedDate);
  //     });
  // }

  // Widget toolbarView(String label) => Container(
  //     height: 80.0,
  //    // padding: EdgeInsets.only(left: 30, bottom: 10),
  //    // alignment: Alignment.centerLeft,
  //     child: Center(
  //       child: Text(label,
  //           style: TextStyle(
  //               color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.w600)),
  //     ),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
  //         color: Colors.white,
  //         shape: BoxShape.rectangle,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.blueGrey.withOpacity(0.2),
  //             offset: const Offset(0, 1.0),
  //             blurRadius: 4.0,
  //             spreadRadius: 2.0,
  //           ),
  //         ]));



  
 

