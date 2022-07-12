import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'routes/home.dart';
import 'routes/start.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      canvasColor: Colors.grey[300],
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Authorization(),
      '/todo': (context) => Home(),
    },
  ));
}
