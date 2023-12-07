import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/Chat/medicine_list_model.dart';
import '../model/Chat/medicine_side_effects_response.dart';

class MedicineAPI{
  static const baseURL = "https://pharma-trac-backend-host.onrender.com/";

  static var client = http.Client();

  static Future<dynamic> getMedicineList() async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}getAllMedicine");

    try{
      final response = await client.get(
        urlFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200){
        var data = jsonDecode(response.body);

        MedicineListModel medicineListModel = MedicineListModel.fromJson(data);
        return medicineListModel.data;
      } else {
        throw Exception('Something went wrong');
      }

    } on Exception catch (e){
      debugPrint(e.toString());
      rethrow;
    }

  }

  static Future<List<String?>?> getMedicineSideEffectsList(String medicineName) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}getMedicineSideEffects")
        .replace(queryParameters: <String, String>{'medicine_name': medicineName});

    try {
      final response = await client.get(
        uriFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        MedicineSideEffectsResponse medicineSideEffectsResponse = MedicineSideEffectsResponse.fromJson(data);

        return medicineSideEffectsResponse.data;

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