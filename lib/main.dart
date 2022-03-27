import 'package:firebase_core/firebase_core.dart';
import 'package:lancer/auth_home_decider.dart';
import 'package:lancer/pages/auth/auth_screen.dart';
import 'package:lancer/pages/home_page.dart';
import 'package:lancer/pages/profile.dart';
import 'package:lancer/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lancer',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: AuthHomeDecider(),
    );
  }
}
