import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userName = '';

setName(_nameController) {
  userName = _nameController.text.trim();
}

Future updateFields(double score, int reward) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User user = auth.currentUser!;
  final String uid = user.uid;
  print('Connected to firebase for ' + uid);
  addDetails(userName, score, reward, uid);
  print('added to friebase for ' + uid);
}


// collection refrence
final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

Future addDetails(String name, double score, int reward, String uid) async {
  return await userCollection.doc(uid).set({
    'Name': name,
    'Score': score,
    'Reward': reward,
  });
}
