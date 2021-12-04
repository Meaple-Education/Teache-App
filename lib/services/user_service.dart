import 'dart:convert';

import 'package:teacher/consts/api.dart';
import 'package:teacher/services/base_service.dart';

class UserService extends BaseService {
  Future fetchProfile() async {
    var result = {
      'status': true,
      'msg': 'Success',
      'data': {},
    };

    await httpGet(
      url: Api.fetchProfileURL,
    ).then((response) {
      var parsedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        result['status'] = false;
        result['msg'] = parsedData['msg'] ?? 'Failed to load profile!';
      } else {
        result['data'] = parsedData['data']['info'];
      }
    });

    return result;
  }
}
