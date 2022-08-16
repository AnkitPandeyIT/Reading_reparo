import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_reparo/SecondScreen.dart';
import 'package:reading_reparo/data/languages.dart';
import 'SpeechScreen.dart';
import 'package:reading_reparo/data/ourPicks.dart';
import 'package:reading_reparo/myColors.dart';
import 'data/bookData.dart';

class LibraryRoute extends StatelessWidget {
  late Map<List, String> reversedData;
  Map<String, List> langBooks = {};
  late String language;
  late String langId;
  late String bookTitle;
  late String bookDesc;
  late String bookCover;
  late String bookContent;
  String bookText = '';
  static String contentLimit = '';

  LibraryRoute(@required String language) {
    this.language = language;

    for (int i = 0; i < bookData.length; i++) {
      if (bookData.values.elementAt(i)[0] == language) {
        langBooks[bookData.keys.elementAt(i)] = bookData.values.elementAt(i);
      }
      reversedData = langBooks.map((key, value) => MapEntry(value, key));
    }
  }

  contentLimitFunc() async {
    bookText = await rootBundle.loadString(bookContent);
    int i = Random().nextInt(20) + 1;
    int j;
    if (i + 31 < bookText.split(" ").length) {
      j = i;
    } else {
      i = i - 31;
      j = i;
    }
    while (i < 30 + j) {
      contentLimit = contentLimit + " " + bookText.split(" ")[i];
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          contentLimit = '';
          language = '';

          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Library'),
            backgroundColor: Colors.black,
          ),
          body: GridView.builder(
            itemCount: langBooks.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Container(
                  height: 100,
                  width: 100,
                  child: IconButton(
                      onPressed: () {
                        langId = reversedData.keys.elementAt(index)[1];
                        bookTitle = reversedData.values.elementAt(index);
                        bookCover = langBooks.values.elementAt(index)[2];
                        bookDesc = langBooks.values.elementAt(index)[3];
                        bookContent = langBooks.values.elementAt(index)[4];
                        contentLimitFunc();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SpeechScreen(
                                    langId,
                                    bookTitle,
                                    bookCover,
                                    bookDesc,
                                    bookText,
                                    contentLimit))));
                      },
                      icon: Image(
                          image: AssetImage(
                              langBooks.values.elementAt(index)[2]))));
            },
          ),
        ));
  }
}
