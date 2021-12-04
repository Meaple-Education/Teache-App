import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:teacher/components/screens/auth/sign_in_screen.dart';
import 'package:teacher/components/screens/auth/sign_up_screen.dart';
import 'package:teacher/components/screens/auth/verify_password_screen.dart';
import 'package:teacher/components/screens/auth/landing_screen.dart';
import 'package:teacher/components/screens/main_screen.dart';
import 'package:teacher/components/screens/splash_screen.dart';
import 'package:teacher/models/auth_model.dart';
import 'package:teacher/models/base_model.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class RestartWidget extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  RestartWidget();

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
      routeObserver = RouteObserver<PageRoute>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseModel>(
          create: (BuildContext context) => BaseModel(),
        ),
        ChangeNotifierProvider<AuthModel>(
          create: (BuildContext context) => AuthModel(),
        ),
      ],
      child: MaterialApp(
        title: dotenv.env['APP_NAME'] ?? 'Teacher app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => SplashScreen(),
          '/main': (BuildContext context) => MainScreen(),
          '/auth': (BuildContext context) => LandingPage(),
          '/auth/sign-in': (BuildContext context) => SignInPage(),
          '/auth/sign-up': (BuildContext context) => const SignUpPage(),
          '/auth/verify/password': (BuildContext context) =>
              VerifyPasswordPage(),
        },
      ),
    );
  }
}
