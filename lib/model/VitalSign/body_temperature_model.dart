///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class BodyTemperatureModelResponse {
/*
{
  "temperature": "116",
  "date": "November 15, 2023",
  "time": "10:20 PM"
}
*/

  String? temperature;
  String? date;
  String? time;

  BodyTemperatureModelResponse({
    this.temperature,
    this.date,
    this.time,
  });
  BodyTemperatureModelResponse.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature']?.toString();
    date = json['date']?.toString();
    time = json['time']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temperature'] = temperature;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}

class BodyTemperatureModel {
/*
{
  "statusCode": 200,
  "message": "Body Temperature data retrieved Successfully",
  "response": [
    {
      "temperature": "116",
      "date": "November 15, 2023",
      "time": "10:20 PM"
    }
  ]
}
*/

  int? statusCode;
  String? message;
  List<BodyTemperatureModelResponse?>? response;

  BodyTemperatureModel({
    this.statusCode,
    this.message,
    this.response,
  });
  BodyTemperatureModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode']?.toInt();
    message = json['message']?.toString();
    if (json['response'] != null) {
      final v = json['response'];
      final arr0 = <BodyTemperatureModelResponse>[];
      v.forEach((v) {
        arr0.add(BodyTemperatureModelResponse.fromJson(v));
      });
      response = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (response != null) {
      final v = response;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['response'] = arr0;
    }
    return data;
  }
}