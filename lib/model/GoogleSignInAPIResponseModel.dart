class GoogleSignInAPIResponseModel {
  GoogleSignInAPIResponseModel({
    required this.googleSignInAccount,
  });
  late final GoogleSignInAccount googleSignInAccount;

  GoogleSignInAPIResponseModel.fromJson(Map<String, dynamic> json){
    googleSignInAccount = GoogleSignInAccount.fromJson(json['GoogleSignInAccount']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['GoogleSignInAccount'] = googleSignInAccount.toJson();
    return _data;
  }
}

class GoogleSignInAccount {
  GoogleSignInAccount({
    required this.displayName,
    required this.email,
    required this.id,
    required this.photoUrl,
    required this.serverAuthCode,
  });
  late final String displayName;
  late final String email;
  late final String id;
  late final String photoUrl;
  late final String serverAuthCode;

  GoogleSignInAccount.fromJson(Map<String, dynamic> json){
    displayName = json['displayName'];
    email = json['email'];
    id = json['id'];
    photoUrl = json['photoUrl'];
    serverAuthCode = json['serverAuthCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['displayName'] = displayName;
    _data['email'] = email;
    _data['id'] = id;
    _data['photoUrl'] = photoUrl;
    _data['serverAuthCode'] = serverAuthCode;
    return _data;
  }
}