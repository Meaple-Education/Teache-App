import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String apiURL = '';

  static getAPIUrl({String version = 'v1.0'}) {
    if (apiURL.isNotEmpty) return apiURL;

    apiURL = "${dotenv.env['API_URL']}/api/$version/teacher";

    return apiURL;
  }

  static String loginURL = getAPIUrl() + '/auth/login';

  static String registerURL = getAPIUrl() + '/auth/register';

  static String verifyPasswordURL = getAPIUrl() + '/auth/verify/password';

  static String fetchProfileURL = getAPIUrl() + '/auth/profile';
}
