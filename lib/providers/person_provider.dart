import 'package:estate_ease/models/models.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get profile => _userProfile;

  void setUserProfile(UserProfile userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }

  void clearUserProfile() {
    _userProfile = null;
    notifyListeners();
  }
}
