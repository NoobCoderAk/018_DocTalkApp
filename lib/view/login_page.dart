import 'package:chatapp/controller/auth_google.dart';
import 'package:flutter/material.dart';

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
          child: Column(
            children: [
              SquareTile(
                onTap: () => AuthGoogle(),
                imagePath: 'images/signin.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
