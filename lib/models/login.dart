class LoginVM {
  late final String password;
  late final bool? rememberMe;
  late final String username;
  late final String? firebaseToken;

  LoginVM({required this.username, required this.password, this.rememberMe, this.firebaseToken});

  LoginVM.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    rememberMe = json['rememberMe'];
    username = json['username'];
    firebaseToken = json['firebaseToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['password'] = password;
    _data['rememberMe'] = rememberMe;
    _data['username'] = username;
    _data['firebaseToken'] = firebaseToken;

    return _data;
  }
}
