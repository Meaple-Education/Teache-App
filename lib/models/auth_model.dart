import 'package:flutter/material.dart';
import 'package:teacher/dto/profile_dto.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;
  ProfileDTO _profile = ProfileDTO(name: '', email: '', image: '', phone: '');

  bool get isLogin => _isLogin;

  set isLogin(bool status) {
    _isLogin = status;
    notifyListeners();
  }

  ProfileDTO get profile => _profile;

  set profile(ProfileDTO profile) {
    _profile = profile;
    notifyListeners();
  }
}
