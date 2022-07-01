import 'package:animate_do/animate_do.dart';
import 'package:app_flutter_frikiteam/bloc/usuario/usuario_bloc.dart';
import 'package:app_flutter_frikiteam/model/organizer_model.dart';
import 'package:app_flutter_frikiteam/services/organized_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizerProfile extends StatefulWidget {
  final OrganizerModel organizer;
  const OrganizerProfile(this.organizer, {Key? key}) : super(key: key);

  @override
  State<OrganizerProfile> createState() => _OrganizerProfileState();
}

class _OrganizerProfileState extends State<OrganizerProfile> {
  //static Organizer organizer = new Organizer("Abel", "Gutierrez", "https://cdn2.rsvponline.mx/files/rsvp/styles/wide/public/images/main/2016/horentrepre.jpg","abelGuti@gmail.com","abcde");
  bool edit = false;
  bool showPassword = false;
  static String emailEdit = '';
  static String passwordEdit = '';
  static String nameEdit = '';
  static String lastNameEdit = '';
  static String imageEdit = '';

  Future<void> getOrganizer() async {
    setState(() {
      emailEdit = widget.organizer.eMAILORGANIZER!;
      passwordEdit = widget.organizer.pASSWORDORGANIZER!;
      nameEdit = widget.organizer.nAMEORGANIZER!;
      lastNameEdit = widget.organizer.lASTNAMEORGANIZER!;
      imageEdit = widget.organizer.iMAGEORGANIZER!;
    });
  }

  Future<void> editOrganizer() async {
    final organizerService = OrganizerService();
    await organizerService.editOrganizer(
      OrganizerModel(
          eMAILORGANIZER: myControllerEmail.text,
          pASSWORDORGANIZER: myControllerPassword.text,
          nAMEORGANIZER: myControllerName.text,
          lASTNAMEORGANIZER: myControllerLastName.text,
          iMAGEORGANIZER: myControllerImage.text),
      widget.organizer.iD!,
    );
    setState(() {
      emailEdit = myControllerEmail.text;
      passwordEdit = myControllerPassword.text;
      nameEdit = myControllerName.text;
      lastNameEdit = myControllerLastName.text;
      imageEdit = myControllerImage.text;
    });
  }

  TextEditingController myControllerEmail =
      TextEditingController(text: emailEdit);
  TextEditingController myControllerPassword =
      TextEditingController(text: passwordEdit);
  TextEditingController myControllerName =
      TextEditingController(text: nameEdit);
  TextEditingController myControllerLastName =
      TextEditingController(text: lastNameEdit);
  TextEditingController myControllerImage =
      TextEditingController(text: imageEdit);

  void setShowPassword() {
    showPassword = !showPassword;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOrganizer();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
          padding:
              const EdgeInsets.only(top: 5, bottom: 12, left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: ListView(
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
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 2),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: BlocBuilder<UsuarioBloc, UsuarioState>(
                  builder: (context, state) {
                    if (state is UsuarioLoged) {
                      return Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
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
                                    image: NetworkImage(
                                        state.usuario.iMAGEORGANIZER!))),
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
                                    myControllerEmail =
                                        TextEditingController(text: emailEdit);
                                    myControllerPassword =
                                        TextEditingController(
                                            text: passwordEdit);
                                    myControllerName =
                                        TextEditingController(text: nameEdit);
                                    myControllerLastName =
                                        TextEditingController(
                                            text: lastNameEdit);
                                    myControllerImage =
                                        TextEditingController(text: imageEdit);
                                    showPassword = false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<UsuarioBloc, UsuarioState>(builder: (context, state) {
                if (state is UsuarioLoged) {
                  return Container(
                    child: edit == true
                        ? ElasticInLeft(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 8,
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
                                  height: 8,
                                ),
                                Text("Last Name:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 8,
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
                                  height: 8,
                                ),
                                Text("Image:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 8,
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
                                    controller: myControllerImage,
                                    cursorColor: Colors.purple,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14),
                                      prefixIcon: Icon(Icons.image,
                                          color: Colors.purple),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Email:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 8,
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
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text("Contraseña:",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                    )),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFC6C6C6),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
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
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        edit = !edit;
                                        setState(() {
                                          myControllerEmail =
                                              TextEditingController(
                                                  text: emailEdit);
                                          myControllerPassword =
                                              TextEditingController(
                                                  text: passwordEdit);
                                          myControllerName =
                                              TextEditingController(
                                                  text: nameEdit);
                                          myControllerLastName =
                                              TextEditingController(
                                                  text: lastNameEdit);
                                          myControllerImage =
                                              TextEditingController(
                                                  text: imageEdit);
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
                                        await editOrganizer();
                                        context.read<UsuarioBloc>().add(
                                            LoginUserEvent(
                                                OrganizerModel(
                                                    iD: widget.organizer.iD,
                                                    eMAILORGANIZER:
                                                        myControllerEmail.text,
                                                    lASTNAMEORGANIZER:
                                                        myControllerLastName
                                                            .text,
                                                    nAMEORGANIZER:
                                                        myControllerName.text,
                                                    pASSWORDORGANIZER:
                                                        myControllerPassword
                                                            .text,
                                                    iMAGEORGANIZER:
                                                        myControllerImage.text),
                                                'organizer'));
                                        setState(() {
                                          nameEdit = myControllerName.text;
                                          lastNameEdit =
                                              myControllerLastName.text;
                                          emailEdit = myControllerEmail.text;
                                          passwordEdit =
                                              myControllerPassword.text;
                                          imageEdit = myControllerImage.text;
                                        });
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : Text(
                            nameEdit + " " + lastNameEdit,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                  );
                }
                return const CircularProgressIndicator();
              }),
              SizedBox(
                height: 8,
              ),
            ],
          )),
    );
  }

  Widget inputs() {
    return ElasticInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 8,
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
            height: 8,
          ),
          Text("Last Name:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 8,
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
            height: 8,
          ),
          Text("Email:",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              )),
          SizedBox(
            height: 8,
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
            height: 8,
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
            height: 8,
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
                    myControllerImage = TextEditingController(text: imageEdit);
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
                onPressed: () async {
                  edit = !edit;
                  await editOrganizer();
                  setState(() {
                    nameEdit = myControllerName.text;
                    lastNameEdit = myControllerLastName.text;
                    emailEdit = myControllerEmail.text;
                    passwordEdit = myControllerPassword.text;
                    imageEdit = myControllerImage.text;
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
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              )
            ],
          )
        ],
      ),
    );
  }
}
