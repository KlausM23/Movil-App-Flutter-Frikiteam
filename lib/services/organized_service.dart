import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_flutter_frikiteam/model/Organizer.dart';

class OrganizerService {
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
}
