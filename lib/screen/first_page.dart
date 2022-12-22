import 'dart:async';

import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});
  @override
  State<FirstPage> createState() => _Firstpage();
}

class _Firstpage extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushNamed(
        context,
        '/login',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              stops: const [
                0.3,
                0.6,
                0.9
              ],
              colors: [
                Colors.red.shade50,
                Colors.red.shade200,
                Colors.red.shade300,
              ]),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150,
              backgroundColor: Colors.redAccent,
              child: Text(
                'Stisla',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 90,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.red.shade300,
                      blurRadius: 10,
                      offset: const Offset(6.0, 6.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
