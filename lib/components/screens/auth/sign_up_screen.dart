import 'package:flutter/material.dart';
import 'package:teacher/components/atoms/loading_atom.dart';
import 'package:teacher/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final AuthService _authService = AuthService();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  String _msg = '';
  bool _registerComplete = false;

  Future register() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    LoadingWidget.showDefaultDialog(context: context);

    var register = await _authService.register(
      _name.text,
      _email.text,
      _password.text,
    );

    Navigator.pop(context);

    if (!register['status']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          register['msg'],
        ),
      ));
      return;
    }

    _msg = register['msg'];
    _registerComplete = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Register"),
            _registerComplete
                ? Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        _msg,
                        // style: TextStyle(text),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                    ],
                  )
                : Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Name',
                          ),
                          controller: _name,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_emailFocus),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name cannot be empty";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          controller: _email,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_passwordFocus),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          focusNode: _passwordFocus,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          controller: _password,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).unfocus(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty";
                            }

                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () => register(),
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),
            const Text('OR'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/auth/sign-in'),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
