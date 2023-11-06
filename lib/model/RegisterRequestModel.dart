class RegisterRequestModel {
  RegisterRequestModel({
    required this.emailAddress,
    required this.password,
    required this.fullName,
    required this.confirmPassword,
    required this.birthDate,
    required this.gender,
    required this.country,
    required this.height,
    required this.weight,
  });
  late final String emailAddress;
  late final String password;
  late final String fullName;
  late final String confirmPassword;
  late final String birthDate;
  late final String gender;
  late final String country;
  late final String height;
  late final String weight;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    emailAddress = json['email_address'];
    password = json['password'];
    fullName = json['fullName'];
    confirmPassword = json['confirmPassword'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    country = json['country'];
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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
