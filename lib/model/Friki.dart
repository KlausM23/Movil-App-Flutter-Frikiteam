class Friki {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? logo;
  int? dateBirth;

  Friki(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.logo,
      this.dateBirth});

  Friki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    logo = json['logo'];
    dateBirth = json['dateBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['logo'] = this.logo;
    data['dateBirth'] = this.dateBirth;
    return data;
  }
}
