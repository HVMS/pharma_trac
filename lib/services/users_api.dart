import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UsersAPI{
  static const baseURL = "";

  static addUser(Map userData) async{
    try {
      final res = await http.post(Uri.parse("uri"), body: userData);

      if (res.statusCode == 200){
        //
      } else{
        //
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

  }
}