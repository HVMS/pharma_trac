import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_trac/model/User/GoogleSignInAPIResponseModel.dart';
import 'package:pharma_trac/model/User/UserInformation.dart';
import 'package:pharma_trac/model/User/login_request_model.dart';
import '../model/User/RegisterRequestModel.dart';
import '../model/User/login_user_response.dart';
import '../model/User/update_user_response.dart';
import '../model/User/user.model.dart';
import '../model/User/user_register_response_model.dart';

class UsersAPI {
  static const baseURL = "https://pharma-trac-backend-host.onrender.com/";

  static var client = http.Client();

  static Future<LoginUser> login(String emailAddress, String password) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}loginRouter");

    LoginRequestModel loginRequestModel =
        LoginRequestModel(emailAddress: emailAddress, password: password);

    try {
      var response = await client.post(
        urlFinal,
        headers: requestHeaders,
        body: jsonEncode(loginRequestModel.toJson()),
      );

      print(response);
      print(response.body);

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      LoginUser loginUserResponse = LoginUser.fromJson(jsonResponse);

      return loginUserResponse;
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<dynamic> register(UserRegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}register");

    try {
      var response = await client.post(
        urlFinal,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      UserRegisterResponseModel userRegisterResponseModel =
          UserRegisterResponseModel.fromJson(jsonResponse);

      if (userRegisterResponseModel.statusCode == 200) {
        return userRegisterResponseModel.user;
      } else {
        return userRegisterResponseModel.message;
        // return 'Error: ${response.statusCode} - ${json.decode(response.body)['message']}';
      }
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<UserRegisterResponseModel?> registerFinal(
      RegisterRequestModel registerRequestModel) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}registerfinal");

    try {
      var response = await client.post(
        urlFinal,
        headers: requestHeaders,
        body: jsonEncode(registerRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data != null) {
          UserRegisterResponseModel userRegisterResponseModel =
              UserRegisterResponseModel.fromJson(data);
          return userRegisterResponseModel;
        }
      } else {
        throw Exception('Something went wrong');
      }
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<UserInformation> getUserInformation(String userId) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}user")
        .replace(queryParameters: <String, String>{'id': userId});
    print(uriFinal);

    try {
      final response = await client.get(
        uriFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        UserInformation userInformation = UserInformation.fromJson(data);
        print(userInformation);

        return userInformation;
      } else {
        throw Exception('Something went wrong');
      }
    } on Exception catch (e) {
      // Handle exceptions
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<dynamic> googleSignInOption(
      GoogleSignInAPIResponseModel model) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
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

  static Future<UpdateUserResponseUpdatedUser?> updateUserInformation(
      String _id, Map<String, dynamic> userInformation) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}updateUser");

    userInformation['_id'] = _id;

    try {
      final response = await client.patch(
        uriFinal,
        headers: requestHeaders,
        body: jsonEncode(userInformation),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        print(data);

        UpdateUserResponse updateUserResponse =
            UpdateUserResponse.fromJson(data);
        print(updateUserResponse.updatedUser);

        if (updateUserResponse.updatedUser != null) {
          return updateUserResponse.updatedUser;
        }

        return null;
      } else {
        throw Exception('Something went wrong');
      }
    } on Exception catch (e) {
      // Handle exceptions
      debugPrint(e.toString());
      rethrow;
    }
  }
}
