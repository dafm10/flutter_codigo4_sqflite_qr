
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/pages/intro_page.dart';
import 'package:flutter_codigo4_sqflite_qr/pages/register_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VacunApp",
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      home: IntroPage(),
    );
  }
}
