///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class VitalSignModelResultVitalSignRequestBody {
/*
{
  "blood_pressure": "150",
  "pulse_rate": "350"
}
*/

  String? bloodPressure;
  String? pulseRate;

  VitalSignModelResultVitalSignRequestBody({
    this.bloodPressure,
    this.pulseRate,
  });
  VitalSignModelResultVitalSignRequestBody.fromJson(Map<String, dynamic> json) {
    bloodPressure = json['blood_pressure']?.toString();
    pulseRate = json['pulse_rate']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['blood_pressure'] = bloodPressure;
    data['pulse_rate'] = pulseRate;
    return data;
  }
}

class VitalSignModelResult {
/*
{
  "acknowledged": true,
  "insertedId": "65543d4b0ec59edc7fb8e66a",
  "user_id": "6548718fd35014483907d86d",
  "vitalSignRequestBody": [
    {
      "blood_pressure": "150",
      "pulse_rate": "350"
    }
  ],
  "_id": "65543d4b0ec59edc7fb8e66a"
}
*/

  bool? acknowledged;
  String? insertedId;
  String? userId;
  List<VitalSignModelResultVitalSignRequestBody?>? vitalSignRequestBody;
  String? Id;

  VitalSignModelResult({
    this.acknowledged,
    this.insertedId,
    this.userId,
    this.vitalSignRequestBody,
    this.Id,
  });
  VitalSignModelResult.fromJson(Map<String, dynamic> json) {
    acknowledged = json['acknowledged'];
    insertedId = json['insertedId']?.toString();
    userId = json['user_id']?.toString();
    if (json['vitalSignRequestBody'] != null) {
      final v = json['vitalSignRequestBody'];
      final arr0 = <VitalSignModelResultVitalSignRequestBody>[];
      v.forEach((v) {
        arr0.add(VitalSignModelResultVitalSignRequestBody.fromJson(v));
      });
      vitalSignRequestBody = arr0;
    }
    Id = json['_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['acknowledged'] = acknowledged;
    data['insertedId'] = insertedId;
    data['user_id'] = userId;
    if (vitalSignRequestBody != null) {
      final v = vitalSignRequestBody;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['vitalSignRequestBody'] = arr0;
    }
    data['_id'] = Id;
    return data;
  }
}

class VitalSignModel {
/*
{
  "statusCode": 200,
  "message": "Vital Signs added Successfully",
  "result": {
    "acknowledged": true,
    "insertedId": "65543d4b0ec59edc7fb8e66a",
    "user_id": "6548718fd35014483907d86d",
    "vitalSignRequestBody": [
      {
        "blood_pressure": "150",
        "pulse_rate": "350"
      }
    ],
    "_id": "65543d4b0ec59edc7fb8e66a"
  }
}
*/

  int? statusCode;
  String? message;
  VitalSignModelResult? result;

  VitalSignModel({
    this.statusCode,
    this.message,
    this.result,
  });
  VitalSignModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode']?.toInt();
    message = json['message']?.toString();
    result = (json['result'] != null) ? VitalSignModelResult.fromJson(json['result']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}
