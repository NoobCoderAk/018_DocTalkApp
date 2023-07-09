import 'package:chatapp/controller/auth_google.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
        backgroundColor: HexColor("#212A3E"),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'images/applogo.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SquareTile(
                    onTap: () => AuthGoogle().signInWithGoogle(context),
                    imagePath: 'images/signin.png',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
