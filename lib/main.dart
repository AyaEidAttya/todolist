import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/HomeScreen.dart';
import 'package:todolist/screens/Loginscreen.dart';
import 'package:todolist/screens/signupscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBOTC7O4mg3axc1ePrxLSbrstM5u0SODoE',
          appId: '1:592515317572:android:9d3baf2e0a07e49ccd6111',
          messagingSenderId: '592515317572',
          projectId: 'todolistapp-895a7'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth=FirebaseAuth.instance;

   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
      ),
      home: _auth.currentUser!=null?HomeScreen():LoginScreen(),
    );


  }
}
