import 'package:app_flutter_frikiteam/model/event_model.dart';
import 'package:app_flutter_frikiteam/storage/storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_flutter_frikiteam/model/Event.dart';

class EventService {
  Future<List<EventModel>> getEventsByOrganizer(int id, String punto) async {
    final response = await http.get(
        Uri.parse("https://findevents.herokuapp.com/organizer/evento/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    print('Peticion response organizer' + punto);
    print(response.body);
    if (response.statusCode == 200 && response.body != '') {
      final Map<String, dynamic> jsonResponse = json.decode(response.body)[0];
      final List<EventModel> eventos = jsonResponse['events']
          .map<EventModel>((json) => EventModel.fromJson(json))
          .toList();
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

  Future<bool> unfollowEvente(int id_event, int id_friki) async {
    final response = await http.delete(
        Uri.parse(
            'https://findevents.herokuapp.com/follow_event/friki/$id_friki/event/$id_event'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200 && response.body != '') {
      return false;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<bool> followEvent(int idEvent, int idFriki) async {
    final response = await http.post(
        Uri.parse('https://findevents.herokuapp.com/follow_event'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'FRIKI_ID': idFriki,
          'EVENT_ID': idEvent,
        }));

    if (response.statusCode == 201 && response.body != '') {
      return true;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<void> addEvent(EventModel evento) async {
    final response =
        await http.post(Uri.parse('https://findevents.herokuapp.com/event'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(evento.toJson()));
    if (response.statusCode == 201 && response.body != '') {
      return;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<void> editEvent(EventModel evento, int eventId) async {
    final response = await http.put(
        Uri.parse('https://findevents.herokuapp.com/event/$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(evento.toJson()));
    print(evento.organizerModel);
    print(jsonEncode(evento.toJson()));
    print(response.body);
    if (response.statusCode == 200 && response.body != '') {
      return;
    } else {
      throw Exception('Failed to load ');
    }
  }
}
