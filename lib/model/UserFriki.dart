// ignore_for_file: file_names

import 'dart:convert';

UserFriki customerFromJson(String str) => UserFriki.fromJson(json.decode(str));

String customerToJson(UserFriki data) => json.encode(data.toJson());

class UserFriki {
  UserFriki({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.logo,
    required this.dateBirth,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  String logo;
  dynamic dateBirth;

  factory UserFriki.fromJson(Map<String, dynamic> json) => UserFriki(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    logo: json["logo"],
    dateBirth: json["dateBirth"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "logo": logo,
    "dateBirth": dateBirth,
  };
}