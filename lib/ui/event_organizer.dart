import 'package:app_flutter_frikiteam/model/DescriptionEvent.dart';
import 'package:app_flutter_frikiteam/model/Local.dart';
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:app_flutter_frikiteam/model/event_model.dart';
import 'package:app_flutter_frikiteam/model/organizer_model.dart';
import 'package:app_flutter_frikiteam/services/event_information_service.dart';
import 'package:app_flutter_frikiteam/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class EventOrganizer extends StatefulWidget {
  final EventModel evento;
  final OrganizerModel organizer;
  const EventOrganizer(this.evento, this.organizer, {Key? key})
      : super(key: key);

  @override
  State<EventOrganizer> createState() => _EventOrganizerState();
}

class _EventOrganizerState extends State<EventOrganizer> {
  bool editTitle = false;
  bool editLocal = false;
  bool editInfo = false;
  bool assist = false;
  bool editPrice = false;
  String titleEvent = '';
  String imgEvent = "";
  String priceEvent = '';
  String description = "";
  String imgDescription = "";
  static String localAddress = "";
  String imgOrganizer = "";
  String nameOrganizer = "";
  String lastNameOrganizer = "";

  void getData() async {
    titleEvent = widget.evento.nAMEEVENT!;
    imgEvent = widget.evento.lOGO!;
    localAddress = widget.evento.aDDRESS!;
    priceEvent = widget.evento.pRICE!;
    description = widget.evento.dESCRIPTION!;
    imgDescription = widget.evento.lOGO2!;
    imgOrganizer = widget.organizer.iMAGEORGANIZER!;
    nameOrganizer = widget.organizer.nAMEORGANIZER!;
    lastNameOrganizer = widget.organizer.lASTNAMEORGANIZER!;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> _editEvent(String infoController, String nameController,
      String priceController, String adressController) async {
    final service = EventService();
    try {
      await service.editEvent(
          EventModel(
            aDDRESS: adressController,
            dESCRIPTION: infoController,
            nAMEEVENT: nameController,
            pRICE: priceController,
            aMOUNT: 0,
            lOGO2: widget.evento.lOGO2,
            lOGO: widget.evento.lOGO,
            organizerModel: widget.organizer,
          ),
          widget.evento.iD!);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController myControllerTitle =
        TextEditingController(text: titleEvent);
    TextEditingController myControllerLocal =
        TextEditingController(text: localAddress);
    TextEditingController myControllerInfo =
        TextEditingController(text: description);
    TextEditingController myControllerPrice =
        TextEditingController(text: priceEvent);
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
          _heroImage(),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 30,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: editTitle == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        titleEvent,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )),
                      GestureDetector(
                          onTap: () {
                            editTitle = !editTitle;
                            setState(() {});
                          },
                          child: Icon(Icons.settings))
                    ],
                  )
                : Row(
                    children: [
                      Flexible(
                        child: Container(
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
                            cursorColor: Colors.purple,
                            controller: myControllerTitle,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(bottom: 10, left: 8)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await _editEvent(
                              myControllerInfo.text,
                              myControllerTitle.text,
                              myControllerPrice.text,
                              myControllerLocal.text);
                          setState(() {
                            titleEvent = myControllerTitle.text;
                          });

                          editTitle = !editTitle;
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                      GestureDetector(
                          onTap: () {
                            editTitle = !editTitle;
                            setState(() {
                              myControllerTitle =
                                  TextEditingController(text: titleEvent);
                            });
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ))
                    ],
                  ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Información',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          )),
                      editInfo == false
                          ? GestureDetector(
                              onTap: () {
                                editInfo = !editInfo;
                                setState(() {});
                              },
                              child: Icon(Icons.settings))
                          : GestureDetector(
                              onTap: () {
                                editInfo = !editInfo;
                                setState(() {
                                  myControllerInfo =
                                      TextEditingController(text: description);
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: editInfo == false
                          ? Text(
                              description,
                              style: TextStyle(letterSpacing: 1.1, height: 1.5),
                            )
                          : Column(
                              children: [
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
                                  height: 380,
                                  child: TextField(
                                    controller: myControllerInfo,
                                    expands: true,
                                    maxLines: null,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    cursorColor: Colors.purple,
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1.1,
                                        height: 1.5),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await _editEvent(
                                        myControllerInfo.text,
                                        myControllerTitle.text,
                                        myControllerPrice.text,
                                        myControllerLocal.text);
                                    editInfo = !editInfo;
                                    setState(() {
                                      description = myControllerInfo.text;
                                    });
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                )
                              ],
                            )),
                  _promotionalImage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ubicación',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      editLocal == false
                          ? GestureDetector(
                              onTap: () {
                                editLocal = !editLocal;
                                setState(() {});
                              },
                              child: Icon(Icons.settings))
                          : GestureDetector(
                              onTap: () {
                                editLocal = !editLocal;
                                setState(() {
                                  myControllerLocal =
                                      TextEditingController(text: localAddress);
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  editLocal == false
                      ? Text(localAddress)
                      : Row(
                          children: [
                            Flexible(
                              child: Container(
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
                                height: 35,
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.purple,
                                  controller: myControllerLocal,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10, left: 8)),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await _editEvent(
                                    myControllerInfo.text,
                                    myControllerTitle.text,
                                    myControllerPrice.text,
                                    myControllerLocal.text);
                                editLocal = !editLocal;
                                setState(() {
                                  localAddress = myControllerLocal.text;
                                });
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.purple,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20),
                  //PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Precio',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      editLocal == false
                          ? GestureDetector(
                              onTap: () {
                                editPrice = !editPrice;
                                setState(() {});
                              },
                              child: Icon(Icons.settings))
                          : GestureDetector(
                              onTap: () {
                                editLocal = !editLocal;
                                setState(() {
                                  myControllerLocal =
                                      TextEditingController(text: localAddress);
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  editPrice == false
                      ? Text(priceEvent.toString())
                      : Row(
                          children: [
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Color(0xFFC6C6C6),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                height: 35,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.purple,
                                  controller: myControllerPrice,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10, left: 8)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await _editEvent(
                                    myControllerInfo.text,
                                    myControllerTitle.text,
                                    myControllerPrice.text,
                                    myControllerLocal.text);
                                editPrice = !editPrice;
                                setState(() {
                                  priceEvent = myControllerPrice.text;
                                });
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.purple,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _heroImage() {
    return Container(
        height: 200,
        width: double.infinity,
        child: Image.network(imgEvent, fit: BoxFit.cover));
  }

  Container _promotionalImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 150,
      width: double.infinity,
      child: Image.network(imgDescription, fit: BoxFit.cover),
    );
  }

  Widget _itinerario() {
    return ListView.builder(
      physics: const ScrollPhysics(parent: null),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return _itemItinerario();
      },
      itemCount: 1,
    );
  }

  Widget _itemItinerario() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF65295F),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Text(
            'Aqui va un evento con fecha y hora',
            style: TextStyle(color: Colors.white, fontSize: 13),
          )),
    );
  }
}
