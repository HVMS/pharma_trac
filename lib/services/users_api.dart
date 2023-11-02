import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_trac/model/user.model.dart';

import '../model/user_register_response_model.dart';

class UsersAPI{
  static const baseURL = "https://pharma-trac-backend-host.onrender.com/";

  static var client = http.Client();

  static Future<String> register(UserRegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'content-type' : 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}register");

    var response = await client.post(
      urlFinal,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if(response.statusCode == 200){
      //
      return response.body;
    }else{
      //
      return response.body;
    }
  }

  // static addUser(Map userData) async{
  //
  //   print(userData);
  //
  //   var addUserURL = Uri.parse("${baseURL}register");
  //
  //   print("Hello wrold");
  //
  //   try {
  //     final res = await http.post(addUserURL, body: userData);
  //
  //     if (res.statusCode == 200){
  //       // data
  //       var data = jsonDecode(res.body.toString());
  //       print(data);
  //     } else{
  //       // print statusCode != 200 data
  //       debugPrint("Error in getting response");
  //     }
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}