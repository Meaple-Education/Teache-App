import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teacher/bootstrap.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env.dev');
  runApp(RestartWidget());
}
