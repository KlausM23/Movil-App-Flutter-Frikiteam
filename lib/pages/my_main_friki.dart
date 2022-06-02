import 'package:app_flutter_frikiteam/ui/event.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_flutter_frikiteam/model/Event.dart';
class MyMainFriki extends StatefulWidget {
  const MyMainFriki({Key? key}) : super(key: key);
  @override
  State<MyMainFriki> createState() => _MyMainFrikiState();
}

class _MyMainFrikiState extends State<MyMainFriki> {
  final carouselImgs=[
    "https://somosfrikis.com/wp-content/uploads/2019/04/artificial3-5.jpg",
    "https://www.informador.mx/__export/1537728296784/sites/elinformador/img/2018/09/23/friki_fest-mp4_15377282357051280_1.jpg_1571920178.jpg",
    "https://1.bp.blogspot.com/-RngT3BfKQ3o/WKuptzO7n9I/AAAAAAAATHQ/_XDpkzQl93AHSU13JlulZszjKSGnmXDDgCLcB/s1600/ban2.jpg",
    "https://i.ytimg.com/vi/N81TlsMT2so/maxresdefault.jpg"
  ];
  List<Event> events=[
    Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg",10),
    Event("Otaku Fest", "https://i.ytimg.com/vi/_tI92lcuN7A/maxresdefault.jpg",30),
    Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg",10),
    Event("Friki Festival", "https://i.ytimg.com/vi/b3u8fSnCFzY/maxresdefault.jpg",20),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children:<Widget>[

          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.23,
              margin: EdgeInsets.only(top: 23.0,bottom: 22.0),
              child: CarouselSlider(
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                    autoPlayCurve: Curves.easeInOut,
                    autoPlayInterval: Duration(seconds: 5)
                ),
                items: carouselImgs.map((e) => ClipRRect(//es el contenedor de una imagen
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children:<Widget> [
                      Image.network(e,width: MediaQuery.of(context).size.width*0.80,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,)
                    ],
                  ),
                )).toList(),
              )
          ),
          Text(
            "Eventos Momentaneos",
            style: TextStyle(fontSize: 26,fontStyle: FontStyle.normal,color: Colors.deepPurple),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width,
              /*height:  MediaQuery.of(context).size.height*0.36,*/
              child: GridView(
                padding: EdgeInsets.all(8),
                children: events.map((e) => EventItem(e)).toList(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}



class EventItem extends StatelessWidget {
  final Event event;
  const EventItem(this.event,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        /*Navigator.of(context).pushNamed('/event');*/
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> const EventPage())
        );
      },
      child: AspectRatio(
        aspectRatio: 1/1,
        child: Container(
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
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.2)
                    ]
                )
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                  event.title,style: TextStyle(color: Colors.white,fontSize:20)
              ),
            ),
          ),
        ),
      ),
    );
  }
}