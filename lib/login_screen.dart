import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'register_page.dart';
import 'package:form_validator/form_validator.dart';
import 'package:reading_reparo/SecondScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    if(_formKey.currentState!.validate()) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  Future goToRegisterPage() async{
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

@override
  void dispose() {
    email: _emailController.dispose();
    password: _passwordController.dispose();
    super.dispose();
  }

  // Initial Selected Value
  String dropdownvalue = 'Student';

  // List of items in our dropdown menu
  var items = [
    'Student',
    'Teacher',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(

     child: Center(
       child: SingleChildScrollView(
         child: Column(children: [
            // logo png


            // dropdown
            Column(
              children: [
                SizedBox(height: 300),
                DropdownButton(

                  // Initial Value

                    alignment: Alignment(-0.5,-0.5),


                  value: dropdownvalue,


                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),

                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                SizedBox(height: 30,),


                //email field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _emailController,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value!.isEmpty){
                            return ("Please Enter Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        }, onSaved: (value) {
                        _emailController.text = value!;
                      },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),


    // password field

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        validator: (value){
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                        }, onSaved: (value) {
                        _passwordController.text = value!;
                      },

                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                //signIn button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(12)),

                      child: Center(
                        child: Text('Sign In', style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',style: TextStyle(
                      fontWeight: FontWeight.bold,)),
                    GestureDetector(
                      onTap: goToRegisterPage,
                      child: Text(' Register Now',
                      style: TextStyle(color: Colors.red ,
                      fontWeight: FontWeight.bold,),),
                    )
                  ],
                ),

              ],
            ),





            //password field



            //register field


          ],),
       ),
     ),)
    );
  }
}
