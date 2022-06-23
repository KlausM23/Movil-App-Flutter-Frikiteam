import 'dart:convert';
import 'package:app_flutter_frikiteam/model/DescriptionEvent.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';
import 'package:http/http.dart' as http;

class DescriptionEventService {
  Future<DescriptionEvent> getEvent(int id) async {
    final response = await http.get(
        Uri.parse(
            "https://api-frikiteam.herokuapp.com/api/events/$id/information"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body)[0];
      final DescriptionEvent descriptionEvent =
          DescriptionEvent.fromJson(jsonResponse);
      return descriptionEvent;
    } else {
      throw Exception('Failed to load gamer');
    }
  }
}
