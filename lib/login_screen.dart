import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'register_page.dart';
import 'package:reading_reparo/SecondScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim());
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
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
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
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
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
