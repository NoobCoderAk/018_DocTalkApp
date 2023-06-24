import 'package:chatapp/controller/auth_google.dart';
import 'package:flutter/material.dart';

import 'utils/squaretile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/applogo.png',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Selamat datang di DocTalk Mobile",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SquareTile(
                  // onTap: () => AuthGoogle(),
                  imagePath: 'images/signin.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
