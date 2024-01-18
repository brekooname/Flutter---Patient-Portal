import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class Report extends StatelessWidget {
  final String? url1;
  const Report({Key? key, this.url1}) : super(key: key);

  get kPrimaryLightColor => null;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            "Report",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 80,
          ),
          GestureDetector(
              child: Text("Click here to see x-ray image ",
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      color: kPrimaryColor)),
              onTap: _launchURL)
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Html(
            data: """
        <div>Follow<a class='sup'><sup>pl</sup></a> 
          Below hr
            <b>Bold</b>
        <h1>what was sent down to you from your Lord</h1>, 
        and do not follow other guardians apart from Him. Little do 
        <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
        """,
            onLinkTap: (String? url, RenderContext context,
                Map<String, String> attributes, dom.Element? element) {
              print("Opening $url...");
            },
            customRender: {
              "custom_tag": (RenderContext context, Widget child) {
                return Column(children: [child]);
              }
            },
          ),
        ),
      ),
    ]);
  }

  void _launchURL() async {
    if (!await launch(url1!)) throw 'Could not launch $url1';
  }
}
