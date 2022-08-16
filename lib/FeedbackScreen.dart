import 'dart:math';
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

class feedBackScreenRoute extends StatelessWidget {
  late List words;
  late String langId;
  late List content;
  late List<String> wrong;
  late double correct;
  //const feedBackScreenRoute({Key key, @required this.words }) :super(key:key);

  feedBackScreenRoute(@required List<String> words,
      @required List<String> content, @required String langId) {
    this.langId = langId;
    this.words = words;
    this.content = content;
    if (words.length == 0) {
      this.wrong = content;
      this.correct = 0;
    } else {
      this.wrong = (content.where((e) => !words.contains(e))).toList();
      this.wrong.removeWhere((element) => element == ' ');
      this.wrong.removeWhere((element) => element == '  ');
      this.wrong.removeWhere((element) => element == '');
      this.correct = this.content.length - this.wrong.length.toDouble() - 5.0;
    }
  }

  void speakBack(String langId, String word) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(langId);
    await flutterTts.speak(word);
    //await flutterTts.awaitSpeakCompletion(true);
  }

  void _showAlertDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text("Your score is " + correct.toString()),
            actions: [
              MaterialButton(
                  onPressed: () {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Assessment'),
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.only(left: 100, top: 10),
            height: 200,
            width: 200,
            child: PieChart(
              dataMap: <String, double>{'Correct': correct},
              chartType: ChartType.ring,
              baseChartColor: Colors.grey.shade700,
              colorList: [Colors.green.shade400],
              chartValuesOptions:
                  ChartValuesOptions(showChartValuesInPercentage: false),
              totalValue: content.length.toDouble(),
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
                                  backgroundColor: MaterialStateProperty.all(
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
                  correct = 0;
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
              userPreferences.userScore += correct.toInt(); // saving score
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
            text: 'Submit Score',
            sliderRotate: false,
          ),
        ]));
  }
}
