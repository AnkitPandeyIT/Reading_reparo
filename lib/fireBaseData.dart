import 'package:cloud_firestore/cloud_firestore.dart';

addUserDetails(int rewrd, double scr) async {
  await FirebaseFirestore.instance.collection('users').add({
    'Reward' : rewrd,
    'Score' : scr,
  });
}