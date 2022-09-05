import 'dart:convert';

import 'package:flutter_login_register_nodejs/models/notes/add_note_response.dart';
import 'package:flutter_login_register_nodejs/models/auth/login_request_model.dart';
import 'package:flutter_login_register_nodejs/models/auth/login_response_model.dart';
import 'package:flutter_login_register_nodejs/models/auth/register_request_model.dart';
import 'package:flutter_login_register_nodejs/models/auth/register_response_model.dart';
import 'package:flutter_login_register_nodejs/models/notes/update_note_request.dart';
import 'package:http/http.dart' as http;

import '../configs/config.dart';
import '../models/notes/add_note_request.dart';
import '../models/notes/get_all_notes_response_model.dart';
import '../models/auth/profile_response_model.dart';
import 'shared_service.dart';

class APIService {
  static var client = http.Client();
  /////////////////////// authentification ////////////////////////////
  static Future<bool> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(
      Config.apiURL,
      Config.loginAPI,
    );
    print(url);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );
      print(await getUserProfile());
      if (await getUserProfile()) {
        print("user not fetched successfuully");
      } else {
        print("user fetched succefully");
      }
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(
      Config.apiURL,
      Config.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"user": model.toJson()}),
    );

    return registerResponseJson(
      response.body,
    );
  }

  static Future<bool> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();
    print("allez");
    print(loginDetails?.idUser);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${loginDetails?.token}'
    };
    var api = Config.userProfileAPI + loginDetails!.idUser!;

    var url = Uri.https(Config.apiURL, api);
    print(url);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(profileResponseJson(
      response.body,
    ));
    if (response.statusCode == 201) {
      await SharedService.setProfileDetails(
        profileResponseJson(
          response.body,
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  /////////////////////// note ////////////////////////////

  static Future<RegisterResponseModel> deleteNote(
    String id,
  ) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${loginDetails!.token}'
    };

    var url = Uri.https(
      Config.apiURL,
      Config.deleteNoteAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"_id": id}),
    );

    return registerResponseJson(
      response.body,
    );
  }

  static Future<AddNoteResponse> addNote(
    AddNoteRequestModel model,
  ) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${loginDetails!.token}'
    };

    var url = Uri.https(
      Config.apiURL,
      Config.addNoteAPI,
    );

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print("addNoteResponse");
    print(response);

    return addNoteResponseJSON(
      response.body,
    );
  }

  static Future<AddNoteResponse> updateNote(
    UpdateNoteRequest model,
  ) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${loginDetails!.token}'
    };

    var url = Uri.https(
      Config.apiURL,
      Config.updateNoteAPI,
    );
    print(model);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print("addNoteResponse");
    print(response);

    return addNoteResponseJSON(
      response.body,
    );
  }

  static Future<GetAllNotesResponse> getUserNotes() async {
    var loginDetails = await SharedService.loginDetails();
    print('Bearer ${loginDetails?.token}');
    print("allez");
    print(loginDetails?.idUser);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${loginDetails?.token}'
    };
    var api = Config.getAllNotesApi + loginDetails!.idUser!;

    var url = Uri.https(Config.apiURL, api);
    print("mich min henna");
    print(url);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(
      response.body,
    );
    if (response.statusCode == 201) {
      print("fetching notes succefully");
    } else {
      print("errorr in fetching notes");
    }
    return notesResponseJson(
      response.body,
    );
  }

  /////////////////////// era ////////////////////////////

  static void addEraMacAdress(String mac) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    print(loginDetails);

    var url = Uri.https(Config.apiURL, Config.eraAddApi);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"addressMac": mac, "Master": loginDetails!.idUser!}),
    );

    if (response.statusCode == 201) {
      print(response.body);
    } else {
      print("erro in adding adressMac");
    }
  }
}
