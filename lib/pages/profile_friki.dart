import 'package:app_flutter_frikiteam/bloc/usuario/usuario_bloc.dart';
import 'package:app_flutter_frikiteam/model/event_model.dart';
import 'package:app_flutter_frikiteam/model/friki_model.dart';
import 'package:app_flutter_frikiteam/model/organizer_model.dart';
import 'package:app_flutter_frikiteam/pages/search_friki.dart';
import 'package:app_flutter_frikiteam/services/event_service.dart';
import 'package:app_flutter_frikiteam/services/friki_service.dart';
import 'package:app_flutter_frikiteam/services/organized_service.dart';
import 'package:app_flutter_frikiteam/ui/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileFriki extends StatefulWidget {
  FrikiModel actualFriki;
  ProfileFriki(this.actualFriki, {Key? key}) : super(key: key);
  @override
  State<ProfileFriki> createState() => _ProfileFrikiState();
}

class _ProfileFrikiState extends State<ProfileFriki> {
  static List<EventModel> eventsFollow = [];

  Future<FrikiModel> _editFriki(int id, String name, String lastname,
      String email, String password, String image) async {
    final service = FrikiService();
    await service.updateFriki(
        FrikiModel(
            nAMEFRIKI: name,
            eMAILFRIKI: email,
            iMAGEFRIKI: image,
            lASTNAMEFRIKI: lastname,
            pASSWORDFRIKI: password),
        id);
    return await service.getFrikiById(id);
  }

  Future<void> _getOrganizesFollowed(int id) async {
    if (mounted) {
      try {
        final service = OrganizerService();
        organizers = await service.getFollowedOrganizers(id);
        setState(() {});
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }

  Future<void> _getEventsFollowed(int id) async {
    try {
      final service = EventService();
      eventsFollow = await service.getFollowedEvents(id);
      setState(() {});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    _getOrganizesFollowed(widget.actualFriki.iD!);
    _getEventsFollowed(widget.actualFriki.iD!);
    super.initState();
  }

  bool edit = false;
  bool showPassword = false;
  static String emailEdit = '';
  static String passwordEdit = '';
  static String nameEdit = '';
  static String lastNameEdit = '';
  static List<OrganizerModel> organizers = [];

  void setShowPassword() {
    showPassword = !showPassword;
    setState(() {});
  }

  TextEditingController myControllerEmail =
      TextEditingController(text: emailEdit);
  TextEditingController myControllerPassword =
      TextEditingController(text: passwordEdit);
  TextEditingController myControllerName =
      TextEditingController(text: nameEdit);
  TextEditingController myControllerLastName =
      TextEditingController(text: lastNameEdit);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 12, left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: BlocBuilder<UsuarioBloc, UsuarioState>(
          builder: (context, state) {
            if (state is UsuarioLoged) {
              myControllerName =
                  TextEditingController(text: state.usuario.nAMEFRIKI);
              myControllerLastName =
                  TextEditingController(text: state.usuario.lASTNAMEFRIKI);
              myControllerEmail =
                  TextEditingController(text: state.usuario.eMAILFRIKI);
              myControllerPassword =
                  TextEditingController(text: state.usuario.pASSWORDFRIKI);
              return ListView(
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 10),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'login', ((route) => false));
                        },
                        child: const Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: 35,
                        ),
                      )),
                  // usuario

                  Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 2),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2.0,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.2),
                              )
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(state.usuario.iMAGEFRIKI!),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  color: Colors.blue,
                                ),
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    edit = !edit;
                                    setState(() {
                                      myControllerEmail = TextEditingController(
                                          text: emailEdit);
                                      myControllerPassword =
                                          TextEditingController(
                                              text: passwordEdit);
                                      myControllerName =
                                          TextEditingController(text: nameEdit);
                                      myControllerLastName =
                                          TextEditingController(
                                              text: lastNameEdit);
                                      showPassword = false;
                                    });
                                  },
                                ))),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: edit == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 10,
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
                                    controller: myControllerName,
                                    cursorColor: Colors.purple,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14),
                                      prefixIcon: Icon(Icons.account_circle,
                                          color: Colors.purple),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Last Name:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 10,
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
                                    controller: myControllerLastName,
                                    cursorColor: Colors.purple,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14),
                                      prefixIcon: Icon(Icons.account_circle,
                                          color: Colors.purple),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Email:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 10,
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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: myControllerEmail,
                                    cursorColor: Colors.purple,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14),
                                      prefixIcon: Icon(Icons.email,
                                          color: Colors.purple),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Contraseña:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
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
                                    obscureText: !showPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: myControllerPassword,
                                    cursorColor: Colors.purple,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 14),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.purple),
                                        suffixIcon: IconButton(
                                          icon: !showPassword
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
                                          onPressed: setShowPassword,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        edit = !edit;
                                        setState(() {
                                          myControllerName =
                                              TextEditingController(
                                                  text:
                                                      state.usuario.nAMEFRIKI);
                                          myControllerLastName =
                                              TextEditingController(
                                                  text: state
                                                      .usuario.lASTNAMEFRIKI);
                                          myControllerEmail =
                                              TextEditingController(
                                                  text:
                                                      state.usuario.eMAILFRIKI);
                                          myControllerPassword =
                                              TextEditingController(
                                                  text: state
                                                      .usuario.pASSWORDFRIKI);
                                          showPassword = false;
                                        });
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 2,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              width: 2, color: Colors.purple),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        edit = !edit;
                                        try {
                                          final frikiEdited = await _editFriki(
                                              state.usuario.iD,
                                              myControllerName.text,
                                              myControllerLastName.text,
                                              myControllerEmail.text,
                                              myControllerPassword.text,
                                              state.usuario.iMAGEFRIKI);
                                          context.read<UsuarioBloc>().add(
                                              LoginUserEvent(
                                                  frikiEdited, 'friki'));
                                          myControllerName =
                                              TextEditingController(
                                                  text:
                                                      state.usuario.nAMEFRIKI);
                                          myControllerLastName =
                                              TextEditingController(
                                                  text: state
                                                      .usuario.lASTNAMEFRIKI);
                                          myControllerEmail =
                                              TextEditingController(
                                                  text:
                                                      state.usuario.eMAILFRIKI);
                                          myControllerPassword =
                                              TextEditingController(
                                                  text: state
                                                      .usuario.pASSWORDFRIKI);
                                          showPassword = false;
                                          setState(() {});
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.purple,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                    )
                                  ],
                                )
                              ],
                            )
                          : Text(
                              state.usuario.nAMEFRIKI +
                                  " " +
                                  state.usuario.lASTNAMEFRIKI,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                            )),
                  //ANYTHING ELSE
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Organizadores Seguidos",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: Colors.purple,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return imageOrganizer(
                            organizers[index].iMAGEORGANIZER!);
                      },
                      itemCount: organizers.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Eventos Seguidos",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            final event = eventsFollow[index];
                            return EventFollowItem(
                                event, widget.actualFriki.iD!);
                          },
                          itemCount: eventsFollow.length)),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget inputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name:",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
            )),
        SizedBox(
          height: 10,
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
            controller: myControllerName,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.account_circle, color: Colors.purple),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Last Name:",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
            )),
        SizedBox(
          height: 10,
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
            controller: myControllerLastName,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.account_circle, color: Colors.purple),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Email:",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
            )),
        SizedBox(
          height: 10,
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
            keyboardType: TextInputType.emailAddress,
            controller: myControllerEmail,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email, color: Colors.purple),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Contraseña:",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
            )),
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
            obscureText: !showPassword,
            keyboardType: TextInputType.visiblePassword,
            enableSuggestions: false,
            autocorrect: false,
            controller: myControllerPassword,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Colors.purple),
                suffixIcon: IconButton(
                  icon: !showPassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: setShowPassword,
                )),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {
                edit = !edit;
                setState(() {
                  myControllerEmail = TextEditingController(text: emailEdit);
                  myControllerPassword =
                      TextEditingController(text: passwordEdit);
                  myControllerName = TextEditingController(text: nameEdit);
                  myControllerLastName =
                      TextEditingController(text: lastNameEdit);
                  showPassword = false;
                });
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  color: Colors.purple,
                ),
              ),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2, color: Colors.purple),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
            ElevatedButton(
              onPressed: () {
                edit = !edit;
                //_editFriki();
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
            )
          ],
        )
      ],
    );
  }
}

class EventFollowItem extends StatelessWidget {
  final int frikiId;
  final EventModel event;
  EventFollowItem(this.event, this.frikiId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EventPage(eventoCorrespondiente: event, frikiId: frikiId),
          ),
        );
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              image: NetworkImage(event.lOGO!), fit: BoxFit.fill),
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
            child: Text(event.nAMEEVENT!,
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

class imageOrganizer extends StatelessWidget {
  final String img;
  const imageOrganizer(this.img, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(img))),
    );
  }
}
