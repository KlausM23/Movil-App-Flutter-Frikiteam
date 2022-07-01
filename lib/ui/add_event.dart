import 'package:app_flutter_frikiteam/model/DescriptionEvent.dart';
import 'package:app_flutter_frikiteam/model/Local.dart';
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:app_flutter_frikiteam/model/event_model.dart';
import 'package:app_flutter_frikiteam/model/organizer_model.dart';
import 'package:app_flutter_frikiteam/services/event_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class AddEvent extends StatefulWidget {
  final OrganizerModel organizer;
  const AddEvent(this.organizer, {Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String nombre = '';
  String descripcion = '';
  String logo = '';
  String logo2 = '';
  String adress = '';
  String price = '';
  String amount = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        title: const Text('FindEvents'),
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 25),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            color: Color(0XFF65295F),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Agregar nuevo Evento",
            style: TextStyle(fontSize: 26, color: Color(0XFF65295F)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          inputsAdd()
        ],
      ),
    );
  }

  Widget inputsAdd() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Titulo:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                nombre = value;
              },
              cursorColor: Colors.purple,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 7, top: 7),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Logo:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                logo = value;
              },
              cursorColor: Colors.purple,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 7, top: 7),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Información:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 200,
            child: TextField(
              onChanged: (value) {
                descripcion = value;
              },
              expands: true,
              maxLines: null,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: Colors.purple,
              style: TextStyle(
                  color: Colors.black, letterSpacing: 1.1, height: 1.5),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Imagen de referencia:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                logo2 = value;
              },
              cursorColor: Colors.purple,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 7, top: 7),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Price:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                price = value;
              },
              cursorColor: Colors.purple,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 7, top: 7),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Dirección:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0xFFC6C6C6),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                adress = value;
              },
              cursorColor: Colors.purple,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 7, top: 7),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final service = EventService();
                  await service.addEvent(EventModel(
                    nAMEEVENT: nombre,
                    dESCRIPTION: descripcion,
                    aDDRESS: adress,
                    pRICE: price,
                    aMOUNT: 0,
                    lOGO: logo,
                    lOGO2: logo2,
                    organizerModel: widget.organizer,
                  ));
                  Navigator.pop(context, true);
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          )
        ],
      ),
    );
  }
}
