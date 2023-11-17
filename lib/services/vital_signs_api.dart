import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_trac/model/VitalSign/body_temperature_model.dart';
import 'package:pharma_trac/model/VitalSign/heart_rate_model.dart';
import '../model/VitalSign/blood_cholesterol_model.dart';
import '../model/VitalSign/blood_pressure_model.dart';
import '../model/VitalSign/blood_sugar_model.dart';
import '../model/VitalSign/vital_sign_response_model.dart';

class VitalSignsService {
  static const baseURL = "https://pharma-trac-backend-host.onrender.com/";

  static var client = http.Client();

  static Future<dynamic> addVitalSings(
      String userId, Map<String, dynamic> vitalSignsData) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var urlFinal = Uri.parse("${baseURL}addVitalSign");

    print(userId);
    print(vitalSignsData);

    Map<String, dynamic> body = {
      "user_id": userId,
      "vitalSignRequestBody": [vitalSignsData],
    };

    print(jsonEncode(body));

    try {
      var response = await client.post(
        urlFinal,
        headers: requestHeaders,
        body: jsonEncode(body),
      );

      print(response);

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      VitalSignModel vitalSignModel = VitalSignModel.fromJson(jsonResponse);

      if (vitalSignModel.statusCode == 200) {
        print("Success");
        return vitalSignModel;
      } else {
        print("Failed");
        return vitalSignModel.message;
      }
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<BloodPressureModel> getBloodPressureData(String userId) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}getBloodPressure").replace(queryParameters: <String, String>{'user_id' : userId});
    print(uriFinal);

    try {
      final response = await client.get(
        uriFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return BloodPressureModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Something went wrong');
      }
    } on Exception catch (e) {
      // Handle exceptions
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<BloodCholesterolModel> getBloodCholesterol(String userId) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}getBloodCholesterol").replace(queryParameters: <String, String>{'user_id' : userId});
    print(uriFinal);

    try {
      final response = await client.get(
        uriFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return BloodCholesterolModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Something went wrong');
      }
    } on Exception catch (e) {
      // Handle exceptions
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<BloodSugarModel> getBloodSugar(String userId) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}getBloodSugar").replace(queryParameters: <String, String>{'user_id' : userId});
    print(uriFinal);

    try {
      final response = await client.get(
        uriFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return BloodSugarModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Something went wrong');
      }
    } on Exception catch (e) {
      // Handle exceptions
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<BodyTemperatureModel> getBodyTemperature(String userId) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}getBodyTemperature").replace(queryParameters: <String, String>{'user_id' : userId});
    print(uriFinal);

    try {
      final response = await client.get(
        uriFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return BodyTemperatureModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Something went wrong');
      }
    } on Exception catch (e) {
      // Handle exceptions
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<HeartRateModel> getHeartRate(String userId) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    var uriFinal = Uri.parse("${baseURL}getHeartRate").replace(queryParameters: <String, String>{'user_id' : userId});
    print(uriFinal);

    try {
      final response = await client.get(
        uriFinal,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return HeartRateModel.fromJson(jsonDecode(response.body));
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
