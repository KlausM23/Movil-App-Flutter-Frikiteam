import 'package:app_flutter_frikiteam/model/Event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FrikiService {
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
}
