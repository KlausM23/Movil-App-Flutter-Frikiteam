import 'package:app_flutter_frikiteam/model/DescriptionEvent.dart';
import 'package:app_flutter_frikiteam/model/Local.dart';
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';

class EventOrganizer extends StatefulWidget {
  const EventOrganizer({Key? key}) : super(key: key);

  @override
  State<EventOrganizer> createState() => _EventOrganizerState();
}

class _EventOrganizerState extends State<EventOrganizer> {
  bool editTitle=false;
  bool editLocal=false;
  bool editInfo=false;
  bool assist=false;
  static String titleEvent= "hola";
  String imgEvent="event.img";
  double priceEvent=0.0;
  String description="descriptionEvent.description";
  String imgDescription="descriptionEvent.img";
  static String localAddress="local.address";
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
    TextEditingController myControllerTitle = TextEditingController(text: titleEvent);
    TextEditingController myControllerLocal = TextEditingController(text:localAddress);
    TextEditingController myControllerInfo = TextEditingController(text:description);
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
            child: editTitle==false?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(titleEvent, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    )),
                GestureDetector(
                    onTap: (){editTitle=!editTitle;setState(() {});},
                    child: Icon(Icons.settings)
                )
              ],
            ):Row(
              children: [
                Flexible(
                  child:Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color(0xFFC6C6C6),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(0,2),
                        )]
                    ),
                    height: 50,
                    child: TextField(
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.purple,
                      controller: myControllerTitle,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 10,left: 8)
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    editTitle=!editTitle;
                    setState(() {
                      titleEvent=myControllerTitle.text;
                    });
                  },
                  child:Text("Save",style: TextStyle(
                    fontSize:14,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal:10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                  ),
                ),
                GestureDetector(
                    onTap: (){editTitle=!editTitle;
                      setState(() {myControllerTitle=TextEditingController(text: titleEvent);
                      });
                      },
                    child: Icon(Icons.close,color: Colors.red,)
                )
              ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text('Información',
                          style: TextStyle(fontSize: 20, color: Colors.black, )),
                      editInfo==false?GestureDetector(
                          onTap: (){
                            editInfo=!editInfo;
                            setState(() {

                            });
                          },
                          child: Icon(Icons.settings)
                      ):GestureDetector(
                          onTap: (){
                            editInfo=!editInfo;
                            setState(() {
                              myControllerInfo=TextEditingController(text: description);
                            });
                          },
                          child: Icon(Icons.close,color: Colors.red,)
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child:editInfo==false? Text(
                        description,style: TextStyle(letterSpacing: 1.1,height:1.5),
                    ):Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              color: Color(0xFFC6C6C6),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(0,2),
                              )]
                          ),
                          height: 380,
                          child: TextField(
                            controller: myControllerInfo,
                            expands: true,
                            maxLines: null,
                            enableSuggestions: false,
                            autocorrect: false,
                            cursorColor: Colors.purple,
                            style: TextStyle(color: Colors.black,letterSpacing: 1.1,height: 1.5),
                            decoration:InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            editInfo=!editInfo;
                            setState(() {
                              description=myControllerInfo.text;
                            });
                          },
                          child:Text("Save",style: TextStyle(
                            fontSize:18,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                          ),
                        )
                      ],
                    )
                  ),
                  _promotionalImage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ubicación',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      editLocal==false?GestureDetector(
                          onTap: (){editLocal=!editLocal;setState(() {});},
                        child:Icon(Icons.settings)
                      ):GestureDetector(
                          onTap: (){editLocal=!editLocal;setState(() {
                            myControllerLocal=TextEditingController(text: localAddress);
                          });},
                          child:Icon(Icons.close,color: Colors.red,)
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  editLocal==false?Text(localAddress):Row(
                    children: [
                      Flexible(
                        child:Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xFFC6C6C6),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(0,2),
                              )]
                          ),
                          height: 35,
                          child: TextField(
                            keyboardType: TextInputType.name,
                            cursorColor: Colors.purple,
                            controller: myControllerLocal,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 10,left: 8)
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          editLocal=!editLocal;
                          setState(() {
                            localAddress=myControllerLocal.text;
                          });
                        },
                        child:Text("Save",style: TextStyle(
                          fontSize:14,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            padding: EdgeInsets.symmetric(horizontal:10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                        ),
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

}
