import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teacher/bootstrap.dart';

Future<void> main() async {
  await DotEnv().load(fileName: 'assets/env/.env');
  runApp(RestartWidget());
}
