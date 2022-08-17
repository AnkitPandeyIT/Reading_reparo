import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_reparo/SpeechScreen.dart';
import 'LibraryScreen.dart';
import 'SecondScreen.dart';
import 'userPreferences.dart';
import 'package:reading_reparo/myColors.dart';
import 'myStyles.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'fireBaseData.dart';
import 'register_page.dart';

class feedBackScreenRoute extends StatelessWidget {
  late List words;
  late String langId;
  late List content;
  late List<String> wrong;
  late double correct;
  int reward = 0;


  //const feedBackScreenRoute({Key key, @required this.words }) :super(key:key);

  feedBackScreenRoute(@required List<String> words,
      @required List<String> content, @required String langId) {
    this.langId = langId;
    this.words = words;
    this.content = content;
    this.wrong = (content.where((e) => !words.contains(e))).toList();
    this.wrong.removeWhere((element) => element == ' ');
    this.wrong.removeWhere((element) => element == '  ');
    this.wrong.removeWhere((element) => element == '');
    this.correct = this.content.length - this.wrong.length.toDouble();
  }





  void speakBack(String langId, String word) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(langId);
    await flutterTts.speak(word);
    //await flutterTts.awaitSpeakCompletion(true);
  }



  giveReward() {
     double score = (correct / content.length) * 100; // store this as score

    if (score > 90) {
      reward = 5;
      print("before execution");
      updateFields(score,reward);
      print("after execution");


      print("Rewarding " + reward.toString() + ' points');




      return Column(
        children: [
          Image.asset("assets/rewards/coins.gif", height: 100, width: 100),
          Text("You have earned 5 coins")
        ],
      );
    } else if (score > 80) {
      reward = 4; // store reward
      print("before execution");
      updateFields(score,reward);
      print("after execution");

      print("Rewarding " + reward.toString() + ' points');



      return Column(
        children: [
          Image.asset("assets/rewards/coins.gif", height: 100, width: 100),
          Text("You have earned 4 coins")
        ],
      );
    } else if (score > 70) {
      reward = 3; // store reward
      print("before execution");
      updateFields(score,reward);
      print("after execution");

      print("Rewarding " + reward.toString() + ' points');

      return Column(
        children: [
          Image.asset("assets/rewards/coins.gif", height: 100, width: 100),
          Text("You have earned 3 coins")
        ],
      );
    } else if (score > 60) {
      reward = 2; // store reward
      print("before execution");
      updateFields(score,reward);
      print("after execution");

      print("Rewarding " + reward.toString() + ' points');



      return Column(
        children: [
          Image.asset("assets/rewards/coins.gif", height: 100, width: 100),
          Text("You have earned 2 coins")
        ],
      );
    } else if (score > 50) {
      reward = 1; // stoe reward
      print("before execution");
      updateFields(score,reward);
      print("after execution");

      print("Rewarding " + reward.toString() + ' points');



      return Column(
        children: [
          Image.asset("assets/rewards/coins.gif", height: 100, width: 100),
          Text("You have earned 1 coins")
        ],
      );
    } else {
      reward = 0; //store reward
      print("before execution");
      updateFields(score,reward);
      print("after execution");
      print("Rewarding " + reward.toString() + ' points');


      return Text("Better luck next time!");

    }



  }




  // reward dialog box
  void _showAlertDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              width: 150,
              height: 150,
              child: giveReward(),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    // store coins
                    // flush variables

                    SecondRoute.contentLimit = '';
                    LibraryRoute.contentLimit = '';
                    langId = '';
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SecondRoute())));
                  },
                  child: Text("Continue"))
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('Assessment'),
            ),
            body: ListView(children: [
              Container(
                padding: EdgeInsets.only(left: 100, top: 10),
                height: 200,
                width: 200,
                child: PieChart(
                  dataMap: <String, double>{
                    'Correct': (correct / content.length) * 100
                  },
                  chartType: ChartType.ring,
                  baseChartColor: Colors.grey.shade700,
                  colorList: [Colors.green.shade400],
                  chartValuesOptions:
                  ChartValuesOptions(showChartValuesInPercentage: true),
                  totalValue: 100,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Let's review what you got wrong",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Scrollbar(
                      thickness: 10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: wrong.length,
                        itemBuilder: (((context, index) {
                          return Container(
                              padding: EdgeInsets.all(5),
                              child: ElevatedButton(
                                  onPressed: () {
                                    speakBack(langId, wrong[index]);
                                  },
                                  child: Text(
                                    wrong[index],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.blue[500]),
                                      shape: myRoundedBorder(20),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(240, 130)))));
                        })),
                      ))),
              Container(
                  padding: EdgeInsets.all(100),
                  child: ElevatedButton(
                    onPressed: () {
                      words = [];
                      Navigator.pop(context);
                    },
                    child: Text("Retry?"),
                    style: ButtonStyle(
                        shape: myRoundedBorder(20),
                        fixedSize: MaterialStateProperty.all(Size(50, 50))),
                  )),
              SlideAction(
                onSubmit: () async {
                  _showAlertDialog(context);
                },
                borderRadius: 12,
                elevation: 10,
                innerColor: Colors.blue.shade200,
                outerColor: Colors.blue.shade500,
                sliderButtonIcon: const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.white,
                ),
                text: 'Claim reward!',
                sliderRotate: false,
              ),
            ])));
  }

}