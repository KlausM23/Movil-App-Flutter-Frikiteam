import 'package:app_flutter_frikiteam/model/DescriptionEvent.dart';
import 'package:app_flutter_frikiteam/model/Local.dart';
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:app_flutter_frikiteam/model/event_model.dart';
import 'package:app_flutter_frikiteam/services/event_information_service.dart';
import 'package:app_flutter_frikiteam/services/event_service.dart';
import 'package:app_flutter_frikiteam/services/organized_service.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class EventPage extends StatefulWidget {
  EventModel eventoCorrespondiente;
  final int frikiId;
  EventPage(
      {Key? key, required this.eventoCorrespondiente, required this.frikiId})
      : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool assist = false;
  String titleEvent = "hola";
  String imgEvent =
      "https://portal.andina.pe/EDPfotografia3/Thumbnail/2022/03/08/000851626W.jpg";
  double priceEvent = 0.0;
  String description = "descriptionEvent.description";
  String imgDescription =
      "https://portal.andina.pe/EDPfotografia3/Thumbnail/2022/03/08/000851626W.jpg";
  String localAddress = "local.address";
  String imgOrganizer =
      "https://steamuserimages-a.akamaihd.net/ugc/915797707427426369/E3349D95D23CAFA4CCC53DC56D4381BE6534FC42/";
  String nameOrganizer = "a";
  String lastNameOrganizer = "a";
  void getData() async {
    Local local = new Local("Plaza Mole del sur 760");
    localAddress = local.address;
  }

  Future<void> _isFollowed() async {
    final service = EventService();
    final isFollowed = await service.eventIsFollowed(
        widget.eventoCorrespondiente.iD!, widget.frikiId);
    setState(() {
      assist = isFollowed;
    });
  }

  Future<void> _changeFollow() async {
    final service = EventService();
    if (assist == true) {
      final changedFollowed = await service.unfollowEvente(
          widget.eventoCorrespondiente.iD!, widget.frikiId);
      setState(() {
        assist = changedFollowed;
      });
    } else {
      final changedFollowed = await service.followEvent(
          widget.eventoCorrespondiente.iD!, widget.frikiId);
      setState(() {
        assist = changedFollowed;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _isFollowed();
  }

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
            _heroImage(),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    widget.eventoCorrespondiente.nAMEEVENT!,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  )),
                  Positioned(
                    top: 3,
                    left: -18,
                    child: assist
                        ? OutlinedButton(
                            onPressed: () {
                              _changeFollow();
                            },
                            child: Text(
                              "UnFollow",
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1,
                                color: Color.fromARGB(255, 209, 108, 14),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                                side:
                                    BorderSide(width: 2, color: Colors.purple),
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _changeFollow();
                            },
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 209, 108, 14),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                  ),
                ],
                clipBehavior: Clip.none,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    const Text('Información',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    const SizedBox(height: 20),
                    //TODO: aqui empieza el futurebuilder
                    Column(
                      children: [
                        Center(
                          child: Text(
                            widget.eventoCorrespondiente.dESCRIPTION!,
                            style: TextStyle(letterSpacing: 1.1, height: 1.5),
                          ),
                        ),
                        _promotionalImage(widget.eventoCorrespondiente.lOGO!),
                      ],
                    ),

                    //TODO: AQUI TERMINA EL FUTUREBUILDER
                    Text('Ubicación',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    const SizedBox(height: 20),
                    Text(widget.eventoCorrespondiente.aDDRESS!),
                    const SizedBox(height: 20),
                    const Text('Organizador',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    Column(
                      children: [
                        _organizador(
                            imageLogo: widget.eventoCorrespondiente
                                .organizerModel!.iMAGEORGANIZER!),
                        Text(
                            widget.eventoCorrespondiente.organizerModel!
                                    .nAMEORGANIZER! +
                                " " +
                                widget.eventoCorrespondiente.organizerModel!
                                    .lASTNAMEORGANIZER!,
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),

                    const SizedBox(height: 30),
                    _asistirButton(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Container _heroImage() {
    return Container(
        height: 200,
        width: double.infinity,
        child: Image.network(widget.eventoCorrespondiente.lOGO!,
            fit: BoxFit.cover));
  }

  Container _promotionalImage(String img) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 150,
      width: double.infinity,
      child: Image.network(img, fit: BoxFit.cover),
    );
  }

  Widget _organizador({required String imageLogo}) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(imageLogo),
    );
  }

  Widget _asistirButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                /*return _modalBottom();*/
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return _modalBottom();
                });
              });
        });
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 209, 108, 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Text(
          'Asistir',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _modalBottom() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 400,
      child: ListView(
        physics: const ScrollPhysics(parent: null),
        children: [
          Column(
            children: [
              Text(
                widget.eventoCorrespondiente.pRICE!.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cantidad de entradas',
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ingrese su número de tarjeta',
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'MM/AA',
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'CVC',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 209, 108, 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'Pagar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
            ],
          ),
        ],
      ),
    );
  }
}
