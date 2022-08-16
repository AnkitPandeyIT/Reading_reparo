import 'dart:ffi';

import "package:flutter/material.dart";
import 'package:reading_reparo/myColors.dart';
import 'SecondScreen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'data/selfAssessmentData.dart';

int index = 0;

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _isListening = false;
  bool _isFinished = false;
  stt.SpeechToText _speech = stt.SpeechToText();
  double _confidence = 1.0;
  String _text = '';
  String langId = '';
  String savedWords = '';
  List readingText = [];
  List spokenText = [];
  List wrong = [];
  double correct = 0.0;
  List content = [];
  late String yourLevel;

  _listen(index) async {
    savedWords = "";
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val to ' + langId),
        onError: (val) => print('onError : $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
          localeId: quizWords.values.elementAt(index),
        );
      }
    } else {
      setState(() => {_isListening = false, _isFinished = true});

      savedWords = _text;

      _speech.stop();
    }
  }

  calculateScore(index) {
    readingText = quizWords.keys.elementAt(index).toLowerCase().split(" ");
    spokenText = savedWords.toLowerCase().split(" ");
    wrong = (readingText.where((e) => !spokenText.contains(e))).toList();
    correct = correct + readingText.length - wrong.length.toDouble();
  }

  void _showAlertDialog() {
    if (correct > 70) {
      yourLevel = 'Fluent';
    } else if (correct > 40) {
      yourLevel = 'Intermediate';
    } else {
      yourLevel = 'Beginner';
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Result"),
            content: Text("Your reading level is " + yourLevel),
            actions: [
              MaterialButton(
                onPressed: () {
                  correct = 0.0;
                  savedWords = '';
                  Navigator.pop(context);
                },
                child: Text('Try again'),
              ),
              MaterialButton(
                  onPressed: () {
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
        title: Text('Quiz'),
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: Column(children: [
        AnimatedSwitcher(
          duration: Duration(seconds: 2),
          child: Container(
              padding: EdgeInsets.only(left: 10, top: 150),
              child: Text(
                quizWords.keys.elementAt(index),
                style: TextStyle(
                    fontFamily: 'Jeju-Gothic',
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              )),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
            child: Text(
          _text,
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'Jeju-Gothic',
              fontWeight: FontWeight.w300),
        )),
      ])),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _isFinished = false;
            _listen(index);
            calculateScore(index);
            if (_isFinished == true) {
              if (index < quizWords.length - 1) {
                index++;
                _text = '';
              } else {
                index = 0;
                _showAlertDialog();
              }
            }
          },
          child: Icon(Icons.mic_rounded)),
    );
  }
}
