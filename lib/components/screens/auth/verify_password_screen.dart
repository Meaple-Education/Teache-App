import 'package:flutter/material.dart';
import 'package:teacher/bootstrap.dart';
import 'package:teacher/components/atoms/loading_atom.dart';
import 'package:teacher/services/auth_service.dart';

class VerifyPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyPasswordPage();
  }
}

class _VerifyPasswordPage extends State<VerifyPasswordPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final FocusNode _otpFocus = FocusNode();
  final AuthService _authService = AuthService();

  Future verifyPassword() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    LoadingWidget.showDefaultDialog(context: context);

    var verifyPassword = await _authService.verifyPassword(
      _password.text,
    );

    Navigator.pop(context);

    if (verifyPassword['data']['logout']) {
      RestartWidget.restartApp(context);
      return;
    }

    if (!verifyPassword['status']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          verifyPassword['msg'],
        ),
      ));
      return;
    }

    RestartWidget.restartApp(context);
  }

  Future logout() async {
    await _authService.removeToken();
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
              const Text("Verify password"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  }

                  return null;
                },
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              ElevatedButton(
                onPressed: () => verifyPassword(),
                child: const Text('Verify'),
              ),
              const Text('OR'),
              ElevatedButton(
                onPressed: () => logout(),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
