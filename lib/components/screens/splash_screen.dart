import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/dto/profile_dto.dart';
import 'package:teacher/models/auth_model.dart';
import 'package:teacher/services/user_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthModel _authModel;
  @override
  void initState() {
    super.initState();
    initLoad();
  }

  initLoad() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var token = sh.getString('token') ?? '';

    if (token.isEmpty) {
      Navigator.pushReplacementNamed(context, '/auth');
      return;
    }

    var isVerified = sh.getBool('isVerify') ?? false;

    if (!isVerified) {
      Navigator.pushReplacementNamed(context, '/auth/verify/password');
      return;
    }

    UserService userService = UserService();
    var fetchProfile = await userService.fetchProfile();

    if (!fetchProfile['status']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          fetchProfile['msg'],
        ),
      ));
      return;
    }

    _authModel.profile = ProfileDTO.fromApi(fetchProfile['data']);

    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    _authModel = Provider.of<AuthModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              dotenv.get('APP_NAME'),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
