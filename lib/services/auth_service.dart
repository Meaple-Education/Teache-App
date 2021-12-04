import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/consts/api.dart';
import 'package:teacher/services/base_service.dart';

class AuthService extends BaseService {
  Future login(
    String email,
    String otp,
  ) async {
    var result = {
      'status': true,
      'msg': 'Success',
      'data': {},
    };

    await httpPost(
      url: Api.loginURL,
      body: {
        'email': email,
        'otp': otp,
      },
    ).then((response) async {
      var parsedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        result['status'] = false;
        result['msg'] = parsedData['msg'] ?? 'Failed to register!';
      } else {
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString('token', parsedData['data']['token']);
        sh.setString(
            'sessionIdentifier', parsedData['data']['sessionIdentifier']);
        sh.setBool('isVerify', false);
      }
    });

    return result;
  }

  Future register(String name, String email, String password) async {
    var result = {
      'status': true,
      'msg': 'Success',
      'data': {},
    };

    await httpPost(
      url: Api.registerURL,
      body: {
        'email': email,
        'name': name,
        'password': password,
      },
    ).then((response) {
      var parsedData = jsonDecode(response.body);
      if (response.statusCode != 201) {
        result['status'] = false;
        result['msg'] = parsedData['msg'] ?? 'Failed to register!';
      } else {
        result['msg'] = parsedData['msg'];
      }
    });

    return result;
  }

  Future verifyPassword(String password) async {
    dynamic result = {
      'status': true,
      'msg': 'Success',
      'data': {
        'logout': false,
      },
    };

    await httpPost(
      url: Api.verifyPasswordURL,
      body: {
        'password': password,
      },
    ).then((response) async {
      var parsedData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        result['status'] = false;
        result['msg'] = parsedData['msg'] ?? 'Failed to register!';
        if (response.statusCode == 401 || parsedData['data']['isExpire']) {
          await removeToken();
          result['data']['logout'] = true;
        }
      } else {
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setBool('isVerify', true);
      }
    });

    return result;
  }
}
