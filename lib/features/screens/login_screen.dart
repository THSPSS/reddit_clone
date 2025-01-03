import 'package:flutter/material.dart';
import 'package:reddit_clone/theme/pallete.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            width: 30,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Skip',
                style: TextStyle(color: Pallete.blueColor),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/loginEmote.png',
            ),
            SizedBox(
              height: 20,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/google.png',
                width: 20,
              ),
              label: Text('Continue with Google'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Pallete.greyColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ));
  }
}
