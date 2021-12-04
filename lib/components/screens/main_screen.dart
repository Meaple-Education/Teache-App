import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teacher/bootstrap.dart';
import 'package:teacher/models/auth_model.dart';
import 'package:teacher/services/base_service.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late AuthModel _authModel;
  @override
  Widget build(BuildContext context) {
    _authModel = Provider.of<AuthModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Techer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text("User name is: ${_authModel.profile.name}"),
              ElevatedButton(
                onPressed: () async {
                  BaseService _baseService = BaseService();
                  _baseService.removeToken();
                  RestartWidget.restartApp(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
