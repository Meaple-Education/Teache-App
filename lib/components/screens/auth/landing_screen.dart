import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingPage();
  }
}

class _LandingPage extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome " + dotenv.get('APP_NAME')),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/auth/sign-in');
              },
              child: const Text('Sign in'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/auth/sign-up');
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
