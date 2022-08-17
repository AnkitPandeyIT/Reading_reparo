import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';



// addUserDetails(int rewrd, double scr) async {
//   await FirebaseFirestore.instance.collection('users').add({
//     'Reward' : rewrd,
//     'Score' : scr,
//   });
// }




 Future updateFields(double score, int reward) async{
   print("executing");
   final FirebaseAuth auth = FirebaseAuth.instance;
   final User user = auth.currentUser!;
   final String uid = user.uid;
   FirebaseFirestore.instance.collection('users').doc(uid).update({'Score': score, 'Reward': reward });

 }

//FirebaseFirestore.instance.collection('collection_name').doc('document_id').update({'field_name': 'Some new data'})



  // collection refrence
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future addDetails(String name, double score, int reward, String uid) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Score': score,
      'Reward': reward,
    });
  }



