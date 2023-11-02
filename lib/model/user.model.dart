// import 'dart:core';
//
// class Users{
//   // late String emailAddress;
//   // // late final String? fullName;
//   // late String password;
//   // // late final DateTime? birthDate;
//   // // late final String? gender;
//   // // late final String? country;
//   // // late final double? height;
//   // // late final double? weight;
//   //
//   // // Users({this.emailAddress, this.fullName, this.password, this.birthDate, this.gender, this.country, this.height, this.weight});
//   //
//   // Users({required this.emailAddress, required this.password});
//
// }

class UserRegisterRequestModel {
  UserRegisterRequestModel({
    required this.emailAddress,
    required this.password,
  });
  late final String emailAddress;
  late final String password;

  UserRegisterRequestModel.fromJson(Map<String, dynamic> json) {
    emailAddress = json['email_address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email_address'] = emailAddress;
    data['password'] = password;
    return data;
  }
}
