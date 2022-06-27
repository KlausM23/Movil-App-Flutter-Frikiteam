import 'dart:convert';
import 'package:app_flutter_frikiteam/model/UserFriki.dart';
import 'package:app_flutter_frikiteam/model/UserOrganizer.dart';
import 'package:http/http.dart' as http;

class FrikiService {
  Future<UserFriki> getCustomerById(int id) async {
    var response = await http.get(
        Uri.parse('https://api-frikiteam.herokuapp.com/api/customers/$id'));
    return UserFriki.fromJson(jsonDecode(response.body));
  }
}

class OrganizerService {
  Future<UserOrganizer> getCustomerById(int id) async {
    var response = await http.get(
        Uri.parse('https://api-frikiteam.herokuapp.com/api/organizers/$id'));
    return UserOrganizer.fromJson(jsonDecode(response.body));
  }
}

class VerifyUser {
  String urlFriki =
      "https://api-frikiteam.herokuapp.com/api/customers?offset=0&sort[sorted]=true&sort[unsorted]=true&sort[empty]=true&pageNumber=0&pageSize=0&paged=true&unpaged=true";
  String urlOrganizer =
      "https://api-frikiteam.herokuapp.com/api/organizers?offset=0&sort[sorted]=true&sort[unsorted]=true&sort[empty]=true&pageNumber=0&pageSize=0&paged=true&unpaged=true";

  List dataRequestFriki = [];
  List dataRequestOrganizer = [];

  Future<String> makeRequestFriki() async {
    var response = await http
        .get(Uri.parse(urlFriki), headers: {'Accept': 'application/json'});

    var extractData = json.decode(response.body);
    dataRequestFriki = extractData['content'];
    /*print("\n--USUARIOS FRIKIS--");
    for (int i = 0; i < dataRequestFriki.length; i++){
      print("Id: " + dataRequestFriki[i]["id"].toString());
      print("Usuario: " + dataRequestFriki[i]["firstName"]);
      print("Email: " + dataRequestFriki[i]["email"]);
      print("Password: " + dataRequestFriki[i]["password"]);
    }*/

    return response.body;
  }

  Future<String> makeRequestOrganizer() async {
    var response = await http
        .get(Uri.parse(urlOrganizer), headers: {'Accept': 'application/json'});
    //print(response.body);

    var extractData = json.decode(response.body);
    dataRequestOrganizer = extractData['content'];
    /*
    print("\n\n--USUARIOS ORGANIZADORES--");
    for (int i = 0; i < dataRequestOrganizer.length; i++){
      print("Id: " + dataRequestFriki[i]["id"].toString());
      print("Usuario: " + dataRequestFriki[i]["firstName"]);
      print("Email: " + dataRequestOrganizer[i]["email"]);
      print("Password: " + dataRequestOrganizer[i]["password"]);
    }*/

    return response.body;
  }
}
