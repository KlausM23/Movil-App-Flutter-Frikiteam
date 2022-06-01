import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class MyMainOrganizer extends StatefulWidget {
  const MyMainOrganizer({Key? key}) : super(key: key);

  @override
  State<MyMainOrganizer> createState() => _MyMainOrganizerState();
}

class _MyMainOrganizerState extends State<MyMainOrganizer> {

  List<Event> events=[
    Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg"),
    Event("Otaku Fest", "https://i.ytimg.com/vi/_tI92lcuN7A/maxresdefault.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,//para poner arriba
          //crossAxisAlignment: CrossAxisAlignment.start,//para poner a la derecha
          children: <Widget> [
            Text(
              "Mis Eventos",
              style: TextStyle(fontSize: 26,fontStyle: FontStyle.normal, fontWeight: FontWeight.bold,  color: Colors.deepPurple),
            ),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (context,index) {
                  final event=events[index];
                  return EventListItem(event);
                },
                itemCount: events.length)
            ),
          ],
        ),
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final Event event;
  const EventListItem(this.event,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
            image: NetworkImage(event.img),
            fit: BoxFit.fill
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent
                ]
            )
        ),

        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
              event.title,style: TextStyle(color: Colors.white,
              fontSize:15,letterSpacing: 7,fontWeight: FontWeight.w700)
          ),
        ),


      ),
    );
  }
}