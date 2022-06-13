import 'package:app_flutter_frikiteam/routes/routes.dart';
import 'package:app_flutter_frikiteam/ui/event.dart';
import 'package:app_flutter_frikiteam/ui/friki_main.dart';
import 'package:app_flutter_frikiteam/ui/login_page.dart';
import 'package:app_flutter_frikiteam/ui/organizer_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FrikiTeam App",
      initialRoute: AppRoutes.initialRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      /*initialRoute: '/login',
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginPage(),
        '/friki': (BuildContext context) => new MainFriki(),
        '/event' : (BuildContext context) => new EventPage(),
        '/organizer':(BuildContext context) => new MainOrganizer(),
      },*/
      routes: AppRoutes.routes,
    ) ;
  }
}
