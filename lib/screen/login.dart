// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobileuas/api/http.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
import '../components/chek_have_account.dart';
import '../screen/registrasi.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool _isObscure = true;

  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();

Future doLogin() async {
    final email = etEmail.text;
    final password = etPassword.text;
    const deviceId = "12345";
    final response = await HttpHelper().login(email, password, deviceId);
    print(response.body);

    SharedPreferences pref = await SharedPreferences.getInstance();
    const key = 'token';
    final value = pref.get(key);
    final token = value;
    if (token == null) {
      Navigator.pushNamed(
        context,
        '/login',
      );
    } else {
      Navigator.pushNamed(
        context,
        '/home',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 248),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/login.png',
                  width: 130,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Color.fromARGB(255, 3, 64, 244),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 249, 249, 249),
                        blurRadius: 10,
                        offset: const Offset(4.0, 4.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                    ),
                    controller: etEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        fontFamily: 'Raleway',
                      ),
                      prefixIcon: const Align(
                        widthFactor: 3.2,
                        heightFactor: 1.5,
                        child: Icon(
                          Icons.mail,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 213, 205, 255)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 205, 207, 255),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                    ),
                    controller: etPassword,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontFamily: 'Raleway',
                      ),
                      prefixIcon: const Align(
                        widthFactor: 3.2,
                        heightFactor: 1.5,
                        child: Icon(
                          Icons.lock,
                        ),
                      ),
                      suffixIcon: Align(
                        widthFactor: 1.7,
                        child: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 218, 205, 255)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 206, 205, 255),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 3, 64, 244),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () async {
                        await doLogin();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Register();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
