import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Belum punya akun ? " : "Sudah punya akun ? ",
          style: const TextStyle(
            color: Colors.red,
            fontFamily: 'Raleway',
          ),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Daftar akun" : "Login",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 255, 81),
              fontWeight: FontWeight.w700,
              fontFamily: 'Raleway',
            ),
          ),
        )
      ],
    );
  }
}
