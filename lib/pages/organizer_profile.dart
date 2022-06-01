import 'package:flutter/material.dart';

class OrganizerProfile extends StatefulWidget {
  const OrganizerProfile({Key? key}) : super(key: key);

  @override
  State<OrganizerProfile> createState() => _OrganizerProfileState();
}

class _OrganizerProfileState extends State<OrganizerProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[

          Text(
            "Mi Perfil",
            style: TextStyle(fontSize: 26,fontStyle: FontStyle.normal, fontWeight: FontWeight.bold,  color: Colors.deepPurple),

          )
        ],
      ),
    );
  }
}
