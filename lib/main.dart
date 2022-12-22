import 'package:flutter/material.dart';
import '../screen/edit_category.dart';
import '../screen/first_page.dart';
import '../screen/home.dart';
import '../screen/login.dart';
import '../screen/registrasi.dart';
import '../api/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const FirstPage(),
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/home": (context) => const Home(),

      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
