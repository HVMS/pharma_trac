// class UserRegisterResponseModel {
//   UserRegisterResponseModel({
//     required this.statusCode,
//     required this.message,
//     required this.user,
//   });
//   late final int statusCode;
//   late final String message;
//   late final User user;
//
//   UserRegisterResponseModel.fromJson(Map<String, dynamic> json){
//     statusCode = json['statusCode'];
//     message = json['message'];
//     user = User.fromJson(json['user']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['statusCode'] = statusCode;
//     _data['message'] = message;
//     _data['user'] = user.toJson();
//     return _data;
//   }
// }
//
// class User {
//   User({
//     required this._id,
//     required this.emailAddress,
//     required this.password,
//   });
//   late final _id _id;
//   late final String emailAddress;
//   late final String password;
//
//   User.fromJson(Map<String, dynamic> json){
//     _id = _id.fromJson(json['_id']);
//     emailAddress = json['email_address'];
//     password = json['password'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = _id.toJson();
//     _data['email_address'] = emailAddress;
//     _data['password'] = password;
//     return _data;
//   }
// }
//
// class _id {
//   _id({
//     required this.$oid,
//   });
//   late final String $oid;
//
//   _id.fromJson(Map<String, dynamic> json){
//     $oid = json['$oid'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['$oid'] = $oid;
//     return _data;
//   }
// }

class UserRegisterResponseModel {
  int? statusCode;
  String? message;
  User? user;

  UserRegisterResponseModel({this.statusCode, this.message, this.user});

  UserRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  Id? iId;
  String? emailAddress;
  String? password;

  User({this.iId, this.emailAddress, this.password});

  User.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? Id.fromJson(json['_id']) : null;
    emailAddress = json['email_address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iId != null) {
      data['_id'] = iId!.toJson();
    }
    data['email_address'] = emailAddress;
    data['password'] = password;
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$oid'] = oid;
    return data;
  }
}
