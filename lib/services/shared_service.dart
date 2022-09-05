import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_register_nodejs/models/auth/login_response_model.dart';
import 'package:flutter_login_register_nodejs/models/auth/profile_response_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    return isCacheKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      print("exist");
      var cacheData = await APICacheManager().getCacheData("login_details");

      return loginResponseJson(cacheData.syncData);
    }
    return null;
  }

  static Future<ProfileResponseModel?> profileDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("profile_details");

    if (isCacheKeyExist) {
      print("exist");
      var cacheData = await APICacheManager().getCacheData("profile_details");

      return profileResponseJson(cacheData.syncData);
    }
    return null;
  }

  static Future<void> setLoginDetails(
    LoginResponseModel loginResponse,
  ) async {
    print("here");
    print(loginResponse.toJson().toString());
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(loginResponse.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> setProfileDetails(
    ProfileResponseModel profileResponse,
  ) async {
    print("heren profile");
    print(profileResponse.toJson().toString());
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "profile_details",
      syncData: jsonEncode(profileResponse.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    await APICacheManager().deleteCache("profile_details");
    print(APICacheManager().getCacheData("profile_details").toString());
    print(APICacheManager().getCacheData("login_details").toString());

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}
