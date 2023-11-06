import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_trac/model/GoogleSignInAPIResponseModel.dart';
import 'package:pharma_trac/model/RegisterRequestModel.dart';
import 'package:pharma_trac/model/user.model.dart';

import '../model/user_register_response_model.dart';

class UsersAPI{
  static const baseURL = "https://pharma-trac-backend-host.onrender.com/";

  static var client = http.Client();

  static Future<dynamic> register(UserRegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'content-type' : 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}register");

    try {
      var response = await client.post(
        urlFinal,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      UserRegisterResponseModel userRegisterResponseModel = UserRegisterResponseModel.fromJson(jsonResponse);

      if(userRegisterResponseModel.statusCode == 200){

        return userRegisterResponseModel.user;

      }else{
        return userRegisterResponseModel.message;
        // return 'Error: ${response.statusCode} - ${json.decode(response.body)['message']}';
      }
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<UserRegisterResponseModel?> registerFinal(RegisterRequestModel registerRequestModel) async {
    Map<String, String> requestHeaders = {
      'content-type' : 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}registerfinal");

    try {
      var response = await client.post(
        urlFinal,
        headers: requestHeaders,
        body: jsonEncode(registerRequestModel.toJson()),
      );

      Map<String, dynamic> jsonResponse = json.decode(response.body);

      return UserRegisterResponseModel.fromJson(jsonResponse);

    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<dynamic> googleSignInOption(GoogleSignInAPIResponseModel model) async {
    Map<String, String> requestHeaders = {
      'content-type' : 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}register");

    try {
      var response = await client.post(
        urlFinal,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      // Map<String, dynamic> jsonResponse = json.decode(response.body);
      // UserRegisterResponseModel userRegisterResponseModel = UserRegisterResponseModel.fromJson(jsonResponse);
      //
      // if(userRegisterResponseModel.statusCode == 200){
      //
      //   return userRegisterResponseModel.user;
      //
      // }else{
      //   return userRegisterResponseModel.message;
      //   // return 'Error: ${response.statusCode} - ${json.decode(response.body)['message']}';
      // }
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      rethrow;
    }
  }
}