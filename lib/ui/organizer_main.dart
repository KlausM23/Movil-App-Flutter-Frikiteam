import 'package:app_flutter_frikiteam/bloc/usuario/usuario_bloc.dart';
import 'package:app_flutter_frikiteam/pages/my_main_organizer.dart';
import 'package:app_flutter_frikiteam/pages/organizer_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainOrganizer extends StatefulWidget {
  const MainOrganizer({Key? key}) : super(key: key);

  @override
  State<MainOrganizer> createState() => _MainOrganizerState();
}

class _MainOrganizerState extends State<MainOrganizer> {
  int currentPage = 0;

  final PageController pageController = PageController(initialPage: 0);

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
            color: Color(0XFF65295F),
          ),
        ),
      ),
      body: BlocBuilder<UsuarioBloc, UsuarioState>(
        builder: (context, state) {
          if (state is UsuarioLoged) {
            return PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                MyMainOrganizer(state.usuario),
                OrganizerProfile(state.usuario)
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          index: currentPage,
          backgroundColor: Colors.transparent,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.person_rounded, size: 30),
          ],
          color: const Color(0xFF65295F),
          onTap: (index) {
            currentPage = index;
            pageController.animateToPage(currentPage,
                duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            setState(() {});
          },
          animationDuration: Duration(milliseconds: 400),
        ),
      ),
    );
  }
}
