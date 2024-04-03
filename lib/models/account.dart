
class Account {
  int? id;
  String? login;
   String? firstName;
  String? lastName;
  String? email;
 // Null phone;
 // Null imageUrl;
  bool? activated;
 // Null langKey;
 // Null newPassword;
  late final List<String>? authorities;

  Account(
      {
        this.id,
        this.login,
          this.firstName,
        this.lastName,
        this.email,
      //  this.phone,
     //   this.imageUrl,
        this.activated,
      //  this.langKey,
      //  this.newPassword,
        required this.authorities});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
 //   phone = json['phone'];
  //  imageUrl = json['imageUrl'];
    activated = json['activated'];
   // langKey = json['langKey'];
   // newPassword = json['newPassword'];
    authorities = json["authorities"] == null ? [] : List<String>.from(json["authorities"]!.map((x) => x));
    // authorities = json['authorities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
      data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
   // data['phone'] = this.phone;
    //data['imageUrl'] = this.imageUrl;
    data['activated'] = this.activated;
    //data['langKey'] = this.langKey;
   // data['newPassword'] = this.newPassword;
    data['authorities'] = this.authorities;
    return data;
  }

  // @override
  // String toString() {
  //   return 'Account{id: $id, login: $login, lastName: $lastName, email: $email, phone: $phone, imageUrl: $imageUrl, activated: $activated, langKey: $langKey, newPassword: $newPassword, authorities: $authorities}';
  // }
}