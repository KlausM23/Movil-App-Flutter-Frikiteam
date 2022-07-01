import 'package:app_flutter_frikiteam/bloc/usuario/usuario_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/pages/my_main_friki.dart';
import 'package:app_flutter_frikiteam/pages/search_friki.dart';
import 'package:app_flutter_frikiteam/pages/profile_friki.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainFriki extends StatefulWidget {
  const MainFriki({Key? key}) : super(key: key);

  @override
  State<MainFriki> createState() => _MainFrikiState();
}

class _MainFrikiState extends State<MainFriki> {
  int currentPge = 1;
  final PageController pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        title: const Text('FindEvents'),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 25),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            /* gradient: LinearGradient(
                colors: [Colors.deepPurple,Colors.purple],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )*/
            color: Color(0XFF65295F),
          ),
        ),
      ),
      body: BlocBuilder<UsuarioBloc, UsuarioState>(
        builder: (context, state) {
          if (state is UsuarioLoged) {
            return PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SearchFriki(state.usuario),
                MyMainFriki(state.usuario),
                ProfileFriki(state.usuario)
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      /*bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPge, //currentIndex es el icono seleccionado
          onTap: (index){
            print(index);
            currentPge=index;
            pageController.animateToPage(currentPge, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            setState(() {});
          },
          selectedItemColor: Color(0xFF5414B0),
          unselectedItemColor: Colors.black.withOpacity(0.7),
          iconSize: 25,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded),label: 'Profile')
          ],
        ),*/
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          index: currentPge,
          backgroundColor: Colors.transparent,
          items: const <Widget>[
            Icon(Icons.search, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.person_rounded, size: 30),
          ],
          color: const Color(0xFF65295F),
          onTap: (index) {
            currentPge = index;
            pageController.animateToPage(currentPge,
                duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            setState(() {});
          },
          animationDuration: Duration(milliseconds: 400),
        ),
      ),
    );
  }
}
