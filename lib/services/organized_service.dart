import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:app_flutter_frikiteam/storage/storage.dart';

class OrganizerService {
  final storage = Storage();

  Future<void> saveToken(String user, String password) async {
    final response = await http.post(
        Uri.parse('https://api-frikiteam.herokuapp.com/api/auth/sign-in'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'username': user, 'password': password}));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'];
      print(token);
      await storage.saveToken(token);
    }
  }

  Future<Organizer> getSomeOrganized(int id) async {
    final response = await http.get(
        Uri.parse("https://api-frikiteam.herokuapp.com/api/organizers/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Organizer organizer = Organizer.fromJson(jsonResponse);
      return organizer;
    } else {
      throw Exception('Failed to load organized');
    }
  }

  Future<List<Organizer>> getOrganizesFollowed(int id) async {
    final response = await http.get(
        Uri.parse(
            'https://api-frikiteam.herokuapp.com/api/customers/$id/organizers'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<Organizer> organizes = jsonResponse['content']
        .map<Organizer>((json) => Organizer.fromJson(json))
        .toList();
    return organizes;
  }

  Future<Organizer> editOrganizer(int id, String firstName, String lastName,
      String email, String password, String logo, String description) async {
    final response = await http.put(
      Uri.parse("https://api-frikiteam.herokuapp.com/api/organizers/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'logo': logo,
        'description': description,
        'verified': true,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Organizer organizer = Organizer.fromJson(jsonResponse);
      return organizer;
    } else {
      throw Exception('Failed to load organized');
    }
  }
}