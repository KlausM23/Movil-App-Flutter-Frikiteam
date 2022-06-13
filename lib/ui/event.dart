
import 'package:app_flutter_frikiteam/model/DescriptionEvent.dart';
import 'package:app_flutter_frikiteam/model/Local.dart';
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool assist=false;
  String titleEvent= "hola";
  String imgEvent="event.img";
  double priceEvent=0.0;
  String description="descriptionEvent.description";
  String imgDescription="descriptionEvent.img";
  String localAddress="local.address";
  String imgOrganizer="a";
  String nameOrganizer="a";
  String lastNameOrganizer="a";
  void getData() async{

     Event event= new Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg",50.0);

     titleEvent=event.title;
     imgEvent=event.img;
     priceEvent=event.price;

     DescriptionEvent descriptionEvent=new DescriptionEvent('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tristique velit ut viverra ornare. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam facilisis egestas turpis, fringilla consequat sem egestas a. Vestibulum sed ante hendrerit, scelerisque tortor a, tincidunt leo. Maecenas eget arcu commodo, imperdiet lorem non, commodo nibh. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi libero nisl, mollis id accumsan vitae, rhoncus a nulla. Quisque vel mattis ex, a gravida erat. Nam euismod risus in elit blandit, ut porta eros eleifend. In posuere volutpat turpis a tempus.Morbi tincidunt tincidunt libero eget condimentum. Integer magna ipsum, consectetur in scelerisque at, pellentesque et nisi. Praesent facilisis aliquam purus non dignissim. Maecenas cursus orci ut luctus dignissim. Nunc sed mi egestas, dignissim odio imperdiet, viverra magna. Mauris id ante dolor. Sed congue eros eget egestas tincidunt. Nam at accumsan dui. Duis ac nisi et diam tincidunt efficitur eu sit amet justo. Ut ac ligula accumsan, vehicula urna a, commodo ante. Ut egestas urna at elit vehicula, vel rutrum erat tempor. Vivamus nec augue pretium, varius enim sed, faucibus velit. Praesent et neque quam.','https://firebasestorage.googleapis.com/v0/b/prueba-43bf8.appspot.com/o/images%2Ffriki%20festival%20informacion%201.jpg?alt=media&token=d6200696-0b53-4488-bd1a-9740c269112c');

     description=descriptionEvent.description;
     imgDescription=descriptionEvent.img;

     Local local=new Local("Plaza Mole del sur 760");
     localAddress=local.address;

     Organizer organizer=new Organizer("Luciana","Herrera","https://portal.andina.pe/EDPfotografia3/Thumbnail/2022/03/08/000851626W.jpg","lucia@gmail.com","lucia789");
     imgOrganizer=organizer.img;
     nameOrganizer=organizer.name;
     lastNameOrganizer=organizer.lastName;
  }
  @override
  void initState() {
    this.getData();
    super.initState();
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
                    child: Text(titleEvent, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                )),
                Positioned(
                  top: 3,
                  left: -18,
                  child: assist?OutlinedButton(
                    onPressed: (){
                      assist=!assist;
                      setState(() {
                      });
                    },
                    child: Text("UnFollow",style: TextStyle(
                      fontSize:16,
                      letterSpacing: 1,
                      color: Color.fromARGB(255, 209, 108, 14),
                    ),),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2,color: Colors.purple),
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                    ),
                  ):ElevatedButton(
                    onPressed: (){
                      assist=!assist;
                      setState(() {
                      });
                    },
                    child:Text("Follow",style: TextStyle(
                      fontSize:16,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 209, 108, 14),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                    ),
                  ),
                ),
              ],
              clipBehavior: Clip.none,
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF65295F),
            child: const Center(
                child: Text('Itinerario',
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          ),
          _itinerario(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: Column(
                children: [
                  const Text('Información',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  const SizedBox(height: 20),
                   Center(
                    child: Text(
                      description
                    ),
                  ),
                  _promotionalImage(),
                  const Text('Ubicación',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  const SizedBox(height: 20),
                  Text(localAddress),
                  const SizedBox(height: 20),
                  const Text('Organizador',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  const SizedBox(height: 20),
                  _organizador(),
                  Text(nameOrganizer+" "+lastNameOrganizer,
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  const SizedBox(height: 30),
                  _asistirButton(),
                  const SizedBox(height: 10),
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
        child: Image.network(
            imgEvent,
            fit: BoxFit.cover));
  }

  Container _promotionalImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 150,
      width: double.infinity,
      child: Image.network(
          imgDescription,
          fit: BoxFit.cover),
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

  Widget _organizador() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(
         imgOrganizer),
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
                    builder: (BuildContext context,StateSetter setState ){

                      return _modalBottom();
                    }
                );
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
                priceEvent.toString(),
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
                  setState(() {

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
