import 'dart:convert';
import 'package:app_flutter_frikiteam/model/organizer_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:app_flutter_frikiteam/storage/storage.dart';

class OrganizerService {
  final storage = Storage();

  Future<OrganizerModel> loginOrganizer(String email, String password) async {
    final response = await http.get(
        Uri.parse(
            'https://findevents.herokuapp.com/organizer/$email/$password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    print(response.body);
    if (response.statusCode == 200) {
      return OrganizerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load login');
    }
  }

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

  Future<void> editOrganizer(
      OrganizerModel organizerEdited, int organizerId) async {
    final response = await http.put(
        Uri.parse('https://findevents.herokuapp.com/organizer/$organizerId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(organizerEdited.toJson()));
    if (response.statusCode == 200 && response.body != '') {
      return;
    } else {
      throw Exception('Failed to edit organizer ');
    }
  }

  Future<List<OrganizerModel>> getFollowedOrganizers(int frikiId) async {
    final response = await http.get(
        Uri.parse(
            "https://findevents.herokuapp.com/follow_organizer/friki/$frikiId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    final List<dynamic> jsonResponse = json.decode(response.body);
    final List<OrganizerModel> organizes = jsonResponse
        .map<OrganizerModel>(
            (json) => OrganizerModel.fromJson(json['ORGANIZER_ID']))
        .toList();
    return organizes;
  }

  Future<void> addOrganizer(OrganizerModel organizer) async {
    final response =
        await http.post(Uri.parse('https://findevents.herokuapp.com/organizer'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(organizer.toJson()));

    if (response.statusCode == 201 && response.body != '') {
      return;
    } else {
      throw Exception('Failed to add organizer');
    }
  }
}
