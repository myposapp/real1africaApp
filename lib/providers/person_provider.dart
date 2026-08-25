import 'package:flutter/material.dart';
import '../models/user_profile.dart';

enum UserSource { none, cache, network }

class ProfileProvider extends ChangeNotifier {
  UserProfile? _userProfile;
  UserSource _source = UserSource.none;

  UserProfile? get profile => _userProfile;
  UserSource get source => _source;

  void setUserProfile(UserProfile userProfile, {required UserSource source}) {
    if (_source == UserSource.network && source == UserSource.cache) {
      return;
    }

    _userProfile = userProfile;
    _source = source;
    notifyListeners();
  }

  void clearUserProfile() {
    _userProfile = null;
    _source = UserSource.none;
    notifyListeners();
  }
}
