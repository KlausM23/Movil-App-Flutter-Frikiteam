import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({Key? key}) : super(key: key);
  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  int currentPge=1;
  final PageController pageController=PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FindEvents',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          title: const Text('FindEvents'),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 25),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
              color: Color(0XFF65295F),
            ),
          ),
        ),
        body: PageView(

        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.white)
          ), child: CurvedNavigationBar(
          index: currentPge,
          backgroundColor: Colors.transparent,
          items: <Widget>[
            Icon(Icons.home, size: 30),
          ],
          color: const Color(0xFF65295F),
          onTap: (index) {
            currentPge=index;
            pageController.animateToPage(currentPge, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            setState(() {});
          },
          animationDuration: Duration(milliseconds: 400),
        ),
        ),
      )
    );
  }
}
