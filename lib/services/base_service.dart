import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BaseService {
  bool _tokenLoaded = false;
  late String _token = '';
  late String _sessionIdentifier = '';

  Future<String> retrieveToken() async {
    if (!_tokenLoaded) {
      SharedPreferences sh = await SharedPreferences.getInstance();
      _token = sh.getString("token") ?? '';
      _sessionIdentifier = sh.getString("sessionIdentifier") ?? '';
      _tokenLoaded = true;
    }

    return _token;
  }

  Future removeToken() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.remove("token");
    sh.remove("sessionIdentifier");
    sh.remove("isVerify");
  }

  Future<http.Response> httpPost({
    url,
    body,
    header,
  }) async {
    Map<String, String> finalHeader = {};

    var device = 1;

    if (Platform.isIOS) {
      device = 2;
    }

    finalHeader.addAll({
      "DeviceType": device.toString(),
      'Accept': 'application/json',
    });

    var token = await retrieveToken();

    if (token.isNotEmpty) {
      finalHeader.addAll({
        'Authorization': 'Bearer ' + token,
        'sessionIdentifier': _sessionIdentifier,
      });
    }

    if (header != null) {
      finalHeader.addAll(header);
    }

    print('------header-------');
    print(finalHeader);
    print('------header-------');

    return http.post(
      Uri.parse(url),
      body: body ?? {},
      headers: finalHeader,
    );
  }

  Future<http.MultipartRequest> httpPostWithFile({
    url,
    header,
  }) async {
    Map<String, String> finalHeader = {};

    var device = 1;

    if (Platform.isIOS) {
      device = 2;
    }

    finalHeader.addAll({
      "DeviceType": device.toString(),
      'Accept': 'application/json',
    });

    var token = await retrieveToken();

    if (token.isNotEmpty) {
      finalHeader.addAll({
        'Authorization': 'Bearer ' + token,
        'sessionIdentifier': _sessionIdentifier,
      });
    }

    finalHeader.addAll({
      'Accept': 'application/json',
    });

    if (header != null) {
      finalHeader.addAll(header);
    }

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );

    request.headers.addAll(finalHeader);

    return request;
  }

  Future<http.Response> httpGet({
    url,
    header,
  }) async {
    Map<String, String> finalHeader = {};

    var device = 1;

    if (Platform.isIOS) {
      device = 2;
    }

    finalHeader.addAll({
      "DeviceType": device.toString(),
      'Accept': 'application/json',
    });

    var token = await retrieveToken();

    if (token.isNotEmpty) {
      finalHeader.addAll({
        'Authorization': 'Bearer ' + token,
        'sessionIdentifier': _sessionIdentifier,
      });
    }

    if (header != null) {
      finalHeader.addAll(header);
    }

    return http.get(
      Uri.parse(url),
      headers: finalHeader,
    );
  }

  Future<http.Response> httpDelete({
    url,
    header,
  }) async {
    Map<String, String> finalHeader = {};

    var device = 1;

    if (Platform.isIOS) {
      device = 2;
    }

    finalHeader.addAll({
      "DeviceType": device.toString(),
      'Accept': 'application/json',
    });

    var token = await retrieveToken();

    if (token.isNotEmpty) {
      finalHeader.addAll({
        'Authorization': 'Bearer ' + token,
        'sessionIdentifier': _sessionIdentifier,
      });
    }

    if (header != null) {
      finalHeader.addAll(header);
    }

    return http.delete(
      Uri.parse(url),
      headers: finalHeader,
    );
  }
}
