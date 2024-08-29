import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/HomeScreen.dart';
import 'package:todolist/screens/Loginscreen.dart';

import '../Serveice/Auth_service.dart';

class SignUpScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Define the color scheme
    Color backgroundColor = Color(0xFF1d2630);
    Color textColor = Colors.white;
    Color borderColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        title: Text('Create Account', style: TextStyle(color: textColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 35,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Register Here',
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _passController,
                style: TextStyle(color: textColor),
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                      onPressed: () async {
                        User? user = await _auth.registerWithEmailAndPassword(
                            _emailController.text, _passController.text);
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        }
                      },
                      child: Center(
                          child: Text(
                        'Register',
                        style: TextStyle(color: Colors.indigo, fontSize: 20),
                      ))),
                ),
              ),
              SizedBox(height: 30),
              Center(
                  child: Text(
                'OR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 20),
              Center(
                child: TextButton(

                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
