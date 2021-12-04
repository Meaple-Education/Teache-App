import 'package:flutter/material.dart';
import 'package:teacher/bootstrap.dart';
import 'package:teacher/components/atoms/loading_atom.dart';
import 'package:teacher/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInPage();
  }
}

class _SignInPage extends State<SignInPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final FocusNode _otpFocus = FocusNode();
  final AuthService _authService = AuthService();

  Future login() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    LoadingWidget.showDefaultDialog(context: context);

    var login = await _authService.login(
      _email.text,
      _otp.text,
    );

    Navigator.pop(context);

    if (!login['status']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          login['msg'],
        ),
      ));
      return;
    }

    RestartWidget.restartApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Sign in page"),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  }

                  return null;
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_otpFocus),
              ),
              TextFormField(
                focusNode: _otpFocus,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'OTP',
                ),
                controller: _otp,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "OTP cannot be empty";
                  }

                  return null;
                },
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              ElevatedButton(
                onPressed: () => login(),
                child: const Text('Login'),
              ),
              const Text('OR'),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/auth/sign-up'),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
