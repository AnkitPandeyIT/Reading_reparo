import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    email: _emailController.dispose();
    password: _passwordController.dispose();
    confirmPassword: _confirmPasswordController.dispose();
    name:   _nameController.dispose();
    super.dispose();
  }

  Future signUp() async{
  if(passwordConfirmed()){
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim()).catchError((e){
    Fluttertoast.showToast(msg: e!.message);
    });
    // add user name to detabase
    addUserName(_nameController.text.trim());
  }
  }

  Future addUserName(String userName) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': userName,
    });
  }

  bool passwordConfirmed(){
    if(_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
    }else{
      return false;
    }

  }

  final _formKey = GlobalKey<FormState>();
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
                    SizedBox(height: 200),
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


                    //name field
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
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Full Name',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value){
                              if(value!.isEmpty){
                                return ("Please Enter your name");
                              }

                          },

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),




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

                    SizedBox(height: 10,),


                    // confirm password field

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
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 10,),

                    //signUp button

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: signUp,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: BorderRadius.circular(12)),

                          child: Center(
                            child: Text('Sign Up', style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),


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
