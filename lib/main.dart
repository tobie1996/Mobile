
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gspresence/firebase_options.dart';
import 'package:gspresence/opening/welcome_page.dart';
import 'package:gspresence/pages/home_page.dart';
import 'package:gspresence/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home:  WelcomePage(),
    );
  }
}
