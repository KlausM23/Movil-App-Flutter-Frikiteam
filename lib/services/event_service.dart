import 'package:app_flutter_frikiteam/model/event_model.dart';
import 'package:app_flutter_frikiteam/storage/storage.dart';
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

  Future<List<Event>> getEventsByOrganizer(int id) async {
    final storage = Storage();
    final response = await http.get(
        Uri.parse(
            "https://api-frikiteam.herokuapp.com/api/organizers/$id/events"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await storage.getToken()}'
        });
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<Event> eventos = jsonResponse['content']
          .map<Event>((json) => Event.fromJson(json))
          .toList();
      return eventos;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<Event> editEvent(
      int organizerId, int eventId, Event eventoModificado) async {
    final storage = Storage();

    final response = await http.put(
        Uri.parse(
            "https://api-frikiteam.herokuapp.com/api/organizers/$organizerId/events/$eventId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await storage.getToken()}'
        },
        body: jsonEncode({
          'logo': eventoModificado.logo,
          'information': eventoModificado.information,
          'name': eventoModificado.name,
          'price': eventoModificado.price,
          'quantity': eventoModificado.quantity,
          'verified': eventoModificado.verified,
          'startDate': eventoModificado.startDate,
          'endDate': eventoModificado.endDate,
          'placeId': eventoModificado.placeId,
          'sold': 1,
        }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Event eventos = Event.fromJson(jsonResponse);
      return eventos;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<List<EventModel>> getEvents() async {
    final response = await http
        .get(Uri.parse("https://findevents.herokuapp.com/event"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200 && response.body != '') {
      final List<dynamic> eventosresponse = json.decode(response.body);
      final List<EventModel> eventos = eventosresponse
          .map<EventModel>((json) => EventModel.fromJson(json))
          .toList();
      return eventos;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<List<EventModel>> getFollowedEvents(int frikiId) async {
    final response = await http.get(
        Uri.parse(
            "https://findevents.herokuapp.com/follow_event/friki/$frikiId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200 && response.body != '') {
      final List<dynamic> eventosresponse = json.decode(response.body);
      final List<EventModel> eventos = eventosresponse
          .map<EventModel>((json) => EventModel.fromJson(json['EVENT_ID']))
          .toList();
      return eventos;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<bool> eventIsFollowed(int eventId, int frikiId) async {
    final response = await http.get(
        Uri.parse(
            "https://findevents.herokuapp.com/follow_event/event/$eventId/friki/$frikiId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200 && response.body != '') {
      final List<dynamic> eventosresponse = json.decode(response.body);
      if (eventosresponse.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to load ');
    }
  }
}
