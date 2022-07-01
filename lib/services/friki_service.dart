import 'package:app_flutter_frikiteam/model/Event.dart';
import 'package:app_flutter_frikiteam/model/Friki.dart';
import 'package:app_flutter_frikiteam/model/friki_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FrikiService {
  Future<FrikiModel> loginFriki(String email, String password) async {
    final response = await http.get(Uri.parse(
        'https://findevents.herokuapp.com/friki/' + email + '/' + password));
    if (response.statusCode == 200 && response.body != "") {
      return FrikiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Friki');
    }
  }

  Future<FrikiModel> getFrikiById(int id) async {
    final response = await http.get(
        Uri.parse('https://findevents.herokuapp.com/friki/' + id.toString()));
    if (response.statusCode == 200 && response.body != "") {
      return FrikiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Friki');
    }
  }

  Future<void> updateFriki(FrikiModel friki, int idFriki) async {
    final response = await http.put(
        Uri.parse('https://findevents.herokuapp.com/friki/$idFriki'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(friki.toJson()));
    if (response.statusCode == 200 && response.body != "") {
      return;
    } else {
      throw Exception('Failed to update Friki');
    }
  }

  Future<List<Event>> getFollowEvents() async {
    final response = await http.get(
        Uri.parse(
            'https://api-frikiteam.herokuapp.com/api/customers/25/events'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<Event> events = jsonResponse['content']
          .map<Event>((json) => Event.fromJson(json))
          .toList();
      return events;
    } else {
      throw Exception('Failed to load follow events');
    }
  }

  Future<Friki> editFriki(Friki friki) async {
    final response = await http.put(
        Uri.parse('https://api-frikiteam.herokuapp.com/api/customers/25'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(friki.toJson()));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Friki frikiResponse = Friki.fromJson(jsonResponse);
      return frikiResponse;
    } else {
      throw Exception('Failed to update friki');
    }
  }

  Future<Friki> getFriki() async {
    final response = await http.get(
        Uri.parse('https://api-frikiteam.herokuapp.com/api/customers/25'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Friki frikiResponse = Friki.fromJson(jsonResponse);
      return frikiResponse;
    } else {
      throw Exception('Failed to load friki');
    }
  }

  Future<void> addFriki(FrikiModel friki) async {
    final response =
        await http.post(Uri.parse('https://findevents.herokuapp.com/friki'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(friki.toJson()));
    if (response.statusCode == 201 && response.body != "") {
      return;
    } else {
      throw Exception('Failed to add friki');
    }
  }
}
