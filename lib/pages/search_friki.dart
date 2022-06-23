import 'package:app_flutter_frikiteam/services/event_service.dart';
import 'package:app_flutter_frikiteam/services/friki_service.dart';
import 'package:app_flutter_frikiteam/ui/event.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class SearchFriki extends StatefulWidget {
  const SearchFriki({Key? key}) : super(key: key);

  @override
  State<SearchFriki> createState() => _SearchFrikiState();
}

class _SearchFrikiState extends State<SearchFriki> {
  static List<Event> eventsSearch = [
    /* Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg",20),
    Event("Otaku Fest", "https://i.ytimg.com/vi/_tI92lcuN7A/maxresdefault.jpg",10),
    Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg",50),
    Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg",50),*/
  ];
  List<Event> eventsFollow = [];
  final _eventService = EventService();
  final _frikiService = FrikiService();
  void _getEvents() async {
    final events = await _eventService.getAllEvents();
    if (mounted)
      setState(() {
        eventsSearch = events;
      });
  }

  void _getEventsFollow() async {
    final events = await _frikiService.getFollowEvents();
    if (mounted)
      setState(() {
        eventsFollow = events;
      });
  }

  @override
  void initState() {
    _getEvents();
    _getEventsFollow();
    print('event generate');
    super.initState();
  }

  List<Event> eventsList = List.from(eventsSearch);
  void updateList(String value) {
    setState(() {
      eventsList = eventsSearch
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, //para poner arriba
          crossAxisAlignment:
              CrossAxisAlignment.start, //para poner a la derecha
          children: <Widget>[
            Text("Encuentra un evento",
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              onChanged: (value) => updateList(value),
              cursorColor: Colors.purple,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFC6C6C6),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none),
                hintText: "ej:FrikiFest",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.purple,
                ), //pre es que va al inicio
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
                child: eventsList.length == 0
                    ? Center(
                        child: Text(
                        "Sin resultados",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final event = eventsList[index];
                          return EventListItem(this.eventsFollow, event);
                        },
                        itemCount: eventsList.length)),
          ],
        ),
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final Event event;
  List<Event> eventsFollow;
  EventListItem(this.eventsFollow, this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool contains = false;
        for (var i = 0; i < eventsFollow.length; i++) {
          if (event.id == eventsFollow[i].id) contains = true;
        }

        if (contains) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventPage(
                eventoCorrespondiente: event,
                seguido: true,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventPage(
                eventoCorrespondiente: event,
                seguido: false,
              ),
            ),
          );
        }
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              image: NetworkImage(event.logo!), fit: BoxFit.fill),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent])),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(event.name!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 10,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}
