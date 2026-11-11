import 'package:flutter/material.dart';
import 'package:school_management/screens/Teacher_Form_Screen.dart';
import 'package:school_management/screens/Teacher_List_Screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const  TeacherListScreen (),
    );
  }
}

