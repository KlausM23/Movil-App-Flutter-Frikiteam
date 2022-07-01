import 'package:app_flutter_frikiteam/model/event_model.dart';
import 'package:app_flutter_frikiteam/model/organizer_model.dart';
import 'package:app_flutter_frikiteam/services/event_service.dart';
import 'package:app_flutter_frikiteam/ui/add_event.dart';
import 'package:app_flutter_frikiteam/ui/event_organizer.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class MyMainOrganizer extends StatefulWidget {
  final OrganizerModel organizer;
  MyMainOrganizer(this.organizer, {Key? key}) : super(key: key);

  @override
  State<MyMainOrganizer> createState() => _MyMainOrganizerState();
}

class _MyMainOrganizerState extends State<MyMainOrganizer> {
  List<EventModel> events = [];
  Future<void> getEvents(String punto) async {
    if (mounted) {
      final organizerService = EventService();
      final events = await organizerService.getEventsByOrganizer(
          widget.organizer.iD!, punto);
      setState(() {
        this.events = events;
      });
    }
  }

  @override
  void initState() {
    getEvents('initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,//para poner arriba
          //crossAxisAlignment: CrossAxisAlignment.start,//para poner a la derecha
          children: <Widget>[
            const Text(
              "Mis Eventos",
              style: TextStyle(
                  fontSize: 26,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return EventListItem(events[index], widget.organizer);
                    },
                    itemCount: events.length)),
            FloatingActionButton(
              onPressed: () async {
                //action code for button 2
                final result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return AddEvent(widget.organizer);
                }));
                if (result) {
                  await getEvents('floating action button');
                  setState(() {});
                }
              },
              backgroundColor: Color(0xFF65295F),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final EventModel event;
  final OrganizerModel organizer;
  EventListItem(this.event, this.organizer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EventOrganizer(event, organizer);
        }));
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              image: NetworkImage(event.lOGO!), fit: BoxFit.fill),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent])),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(event.nAMEEVENT!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 7,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}
