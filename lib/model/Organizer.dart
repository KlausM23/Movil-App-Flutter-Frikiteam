class Organizer {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? logo;
  String? description;
  bool? verified;

  Organizer(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.logo,
      this.description,
      this.verified});

  Organizer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    logo = json['logo'];
    description = json['description'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['logo'] = logo;
    data['description'] = description;
    data['verified'] = verified;
    return data;
  }
}
