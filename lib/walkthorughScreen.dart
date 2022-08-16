import 'package:flutter/material.dart';
import 'package:reading_reparo/FirstScreen.dart';
import 'package:reading_reparo/myColors.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

Map<String, String> walkThroughImage = {
  'Improve your reading the easy way': 'assets/walkthrough/slide-1.png',
  'We used the best tools for a seamless experience':
      'assets/walkthrough/slide-2.png',
  'Get rewarded for your hardwork': 'assets/walkthrough/slide-3.png'
};

int index = 0;

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade300, Colors.blue.shade700])),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child:
                          Image.asset(walkThroughImage.values.elementAt(index)),
                    ))),
                Wrap(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 50, right: 50, top: 100),
                        child: Text(
                          walkThroughImage.keys.elementAt(index),
                          style: TextStyle(
                              fontFamily: 'Jeju-Gothic',
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (index < walkThroughImage.length - 1) {
                index = index + 1;
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => FirstScreen())));
              }
            });
          },
          child: Icon(Icons.next_plan_outlined),
        ));
  }
}
