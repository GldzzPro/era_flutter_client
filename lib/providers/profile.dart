import 'package:flutter/foundation.dart';

import '../models/auth/profile_response_model.dart';

class ProfileProvider extends ChangeNotifier {
  late ProfileResponseModel _profileData;

  ProfileResponseModel get profileData => _profileData;

  setProfileData(ProfileResponseModel data) {
    _profileData = data;
    notifyListeners();
  }
}
