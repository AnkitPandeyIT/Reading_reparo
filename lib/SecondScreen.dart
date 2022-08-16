import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reading_reparo/FirstScreen.dart';
import 'main.dart';
import 'SpeechScreen.dart';
import 'LibraryScreen.dart';
import 'myColors.dart';
import 'myStyles.dart';
import "data/languages.dart";
import "data/ourPicks.dart";
import "data/readingPlans.dart";
import 'data/bookData.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SecondRoute extends StatelessWidget {
  static late String langID;
  //static late String language;
  static String bookTitle = '';
  static String coverPath = '';
  static String bookDesc = '';
  static String bookTextPath = '';
  static var bookContent;
  static String contentLimit = '';

  SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          langID = '';

          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Stack(
              children: [
                Container(
                  height: 50,
                ),
                Row(
                  children: [],
                )
              ],
            ),
            body: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "What language do you want to learn in?",
                    style: TextStyle(
                        fontFamily: 'Jeju-Gothic',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: languages.length,
                      itemBuilder: ((context, index) {
                        return Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
                                langID = languages.values.elementAt(index)[1];
                                var language = languages.keys.elementAt(index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            LibraryRoute(language))));
                              },
                              child: Text(
                                languages.keys.elementAt(index),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  fontFamily: 'Jeju-Gothic',
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[800]),
                                  shape: myRoundedBorder(20),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(240, 130))),
                            ));
                      }),
                    )),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Our Picks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        fontFamily: 'Jeju-Gothic',
                      )),
                ),
                Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: ((context, index) {
                        return Container(
                            padding: EdgeInsets.all(2),
                            child: IconButton(
                              onPressed: () async {
                                langID = bookData.values.elementAt(index)[1];
                                bookTitle = bookData.keys.elementAt(index);
                                coverPath = bookData.values.elementAt(index)[2];
                                bookDesc = bookData.values.elementAt(index)[3];
                                bookTextPath =
                                    bookData.values.elementAt(index)[4];
                                bookContent =
                                    await rootBundle.loadString(bookTextPath);
                                int i = Random().nextInt(20) + 1;
                                int j;
                                if (i + 31 < bookContent.split(" ").length) {
                                  j = i;
                                } else {
                                  i = i - 30;
                                  j = i;
                                }
                                while (i < 30 + j) {
                                  contentLimit = contentLimit +
                                      " " +
                                      bookContent.split(" ")[i];
                                  i++;
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => SpeechScreen(
                                            langID,
                                            bookTitle,
                                            coverPath,
                                            bookDesc,
                                            bookContent,
                                            contentLimit))));
                              },
                              icon: Image(
                                  image: AssetImage(
                                      bookData.values.elementAt(index)[2])),
                              iconSize:
                                  200 /*Text(
                            bookData.keys.elementAt(index),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'Jeju-Gothic',
                            ),
                          ),*/
                              ,
                              /*style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[800]),
                              shape: myRoundedBorder(20),
                              fixedSize:
                                  MaterialStateProperty.all(Size(240, 130))),*/
                            ));
                      }),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Reading Plans",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        fontFamily: 'Jeju-Gothic'),
                  ),
                ),
                Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: readingPlans.length,
                      itemBuilder: ((context, index) {
                        return Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
                                langID = 'en-US';
                              },
                              child: Text(
                                readingPlans[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  fontFamily: 'Jeju-Gothic',
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[800]),
                                  shape: myRoundedBorder(20),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(240, 130))),
                            ));
                      }),
                    )),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
              ],
            )));
  }
}
