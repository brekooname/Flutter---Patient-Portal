import 'package:flutter/material.dart';
import 'package:soul/constants.dart';
import '../MainPage_Screen/main_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor.withOpacity(0.7)),
      ),
      home: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                floating: false,
                pinned: true,
                title: Center(
                  child: Text("CONTACT US",style: TextStyle(       fontSize: 25,
                    color: Color(0xFF056195),),),
                ),
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon:Icon(
                    Icons.arrow_back,
                    color: Color(0xFF056195),
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/images/dimensionslogo.png',
                      fit: BoxFit.cover,
                      // color: Color.fromARGB(255, 15, 147, 59),
                    ),
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildContactCard(
                      icon: FontAwesomeIcons.envelope,
                      label: 'Email',
                      info: 'info@dimensions-infotech.com',
                    ),
                    _buildContactCard(
                      icon: FontAwesomeIcons.phone,
                      label: 'Tel',
                      info: '+970 2 2986 802',
                    ),
                    _buildContactCard(
                      icon: FontAwesomeIcons.globe,
                      label: 'Website',
                      info: 'https://www.dimensions-infotech.com',
                    ),
                    SizedBox(height: 30),  // Spacer at the end
                    Center(
                      child: Text(
                        'Hold the Vision, Trust the Process',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: kPrimaryColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),  // Spacer at the end
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String label,
    required String info,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: kPrimaryColor.withOpacity(0.7)),
        title: Text(label, style: TextStyle(color: kPrimaryColor)),
        subtitle: Text(info),
      ),
    );
  }
}
