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
