///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UserInformationUser {
/*
{
  "_id": "654b188660efba217032f7d7",
  "email_address": "test1111@gmail.com",
  "password": "123456",
  "fullName": "myviral",
  "confirmPassword": "123456",
  "birthDate": "3/11/2023",
  "gender": "male",
  "country": "india",
  "height": "56",
  "weight": "70"
}
*/

  String? Id;
  String? emailAddress;
  String? password;
  String? fullName;
  String? confirmPassword;
  String? birthDate;
  String? gender;
  String? country;
  String? height;
  String? weight;

  UserInformationUser({
    this.Id,
    this.emailAddress,
    this.password,
    this.fullName,
    this.confirmPassword,
    this.birthDate,
    this.gender,
    this.country,
    this.height,
    this.weight,
  });
  UserInformationUser.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    emailAddress = json['email_address']?.toString();
    password = json['password']?.toString();
    fullName = json['fullName']?.toString();
    confirmPassword = json['confirmPassword']?.toString();
    birthDate = json['birthDate']?.toString();
    gender = json['gender']?.toString();
    country = json['country']?.toString();
    height = json['height']?.toString();
    weight = json['weight']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['email_address'] = emailAddress;
    data['password'] = password;
    data['fullName'] = fullName;
    data['confirmPassword'] = confirmPassword;
    data['birthDate'] = birthDate;
    data['gender'] = gender;
    data['country'] = country;
    data['height'] = height;
    data['weight'] = weight;
    return data;
  }
}

class UserInformation {
/*
{
  "statusCode": 200,
  "message": "User found",
  "user": {
    "_id": "654b188660efba217032f7d7",
    "email_address": "test1111@gmail.com",
    "password": "123456",
    "fullName": "myviral",
    "confirmPassword": "123456",
    "birthDate": "3/11/2023",
    "gender": "male",
    "country": "india",
    "height": "56",
    "weight": "70"
  }
}
*/

  int? statusCode;
  String? message;
  UserInformationUser? user;

  UserInformation({
    this.statusCode,
    this.message,
    this.user,
  });
  UserInformation.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode']?.toInt();
    message = json['message']?.toString();
    user = (json['user'] != null) ? UserInformationUser.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}