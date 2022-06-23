import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_flutter_frikiteam/model/Event.dart';

class EventService {
  Future<List<Event>> getAllEvents() async {
    final response = await http.get(
        Uri.parse("https://api-frikiteam.herokuapp.com/api/events"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      final List<Event> eventos =
          jsonResponse.map<Event>((json) => Event.fromJson(json)).toList();
      return eventos;
    } else {
      throw Exception('Failed to load ');
    }
  }
}
