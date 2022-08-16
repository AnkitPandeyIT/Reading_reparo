import 'package:flutter/material.dart';
import 'walkthorughScreen.dart';
import 'FirstScreen.dart';
import "SecondScreen.dart";
import 'SpeechScreen.dart';
import 'package:reading_reparo/myColors.dart';
import "package:reading_reparo/myStyles.dart";
import 'userPreferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await userPreferences.init();
  await userPreferences.isFirstLaunch();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:
          userPreferences.startInt == 0 || userPreferences.startInt == null
              ? 'walkthrough'
              : 'home',
      routes: {
        'walkthrough': (context) => WalkThroughScreen(),
        'home': (context) => FirstScreen()
      },
    );
  }
}
