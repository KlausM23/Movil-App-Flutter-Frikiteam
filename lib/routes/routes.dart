import 'package:app_flutter_frikiteam/ui/add_event.dart';
import 'package:app_flutter_frikiteam/ui/event.dart';
import 'package:app_flutter_frikiteam/ui/event_organizer.dart';
import 'package:app_flutter_frikiteam/ui/friki_main.dart';
import 'package:app_flutter_frikiteam/ui/login_page.dart';
import 'package:app_flutter_frikiteam/ui/organizer_main.dart';
import 'package:app_flutter_frikiteam/ui/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRouter = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginPage(),
    'register': (BuildContext context) => const RegisterPage(),
    //'event': (BuildContext context) => const EventPage(),
    //'eventOrganizer': (BuildContext context) => const EventOrganizer(),
    'friki': (BuildContext context) => const MainFriki(),
    'organizer': (BuildContext context) => const MainOrganizer(),
  };
  static onGeneratedRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}
