import 'dart:developer';

import 'package:app_flutter_frikiteam/model/friki_model.dart';
import 'package:app_flutter_frikiteam/model/organizer_model.dart';
import 'package:app_flutter_frikiteam/pages/term_page.dart';
import 'package:app_flutter_frikiteam/services/friki_service.dart';
import 'package:app_flutter_frikiteam/services/organized_service.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userTypeList = ['Usuario Friki', 'Organizador'];
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _name = "";
  String _lastname = "";
  String _email = "";
  String _password = "";
  String _userType = "Tipo de usuario";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    //color: Colors.red,
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Image.asset(
                          'images/findventsTitle.png',
                        ),
                        Container(
                          child: const Text(
                            "Eventos Frikis más",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 15),
                        ),
                        const Text(
                          "cerca de ti",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 190,
                        ),
                        TextField(
                          controller: nameController,
                          scrollPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            hintText: "Nombre",
                            fillColor: Colors.grey,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: lastnameController,
                          scrollPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            hintText: "Apellido",
                            fillColor: Colors.grey,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: emailController,
                          scrollPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            hintText: "Email",
                            fillColor: Colors.grey,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: passwordController,
                          scrollPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8),
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 3),
                            ),
                            hintText: "Contraseña",
                            fillColor: Colors.grey,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey, width: 3),
                            //border: const Border(color: Colors.grey, width: 3),
                          ),
                          child: DropdownButton<String>(
                            items: _userTypeList.map((String elemento) {
                              return DropdownMenuItem(
                                  value: elemento, child: Text(elemento));
                            }).toList(),
                            isExpanded: true,
                            onChanged: (_value) => {
                              setState(() {
                                //_userType es privado y almacena el valor que selecciona
                                _userType = _value!;
                              })
                            },
                            hint: Text(_userType),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermAndConditions()));
                          },
                          child: const Text(
                            'Al registrarse usted acepta nuestros términos y condiciones.',
                            style: TextStyle(color: Colors.pink),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 45, right: 45),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            color: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () async {
                              _name = nameController.text;
                              _lastname = lastnameController.text;
                              _email = emailController.text;
                              _password = passwordController.text;

                              print("Nombre: " + _name);
                              print("Apellido: " + _lastname);
                              print("Email: " + _email);
                              print("Contraseña: " + _password);
                              print("Tipo de usuario: " + _userType);

                              try {
                                if (_userType == 'Usuario Friki') {
                                  final service = FrikiService();
                                  await service.addFriki(FrikiModel(
                                      nAMEFRIKI: _name,
                                      lASTNAMEFRIKI: _lastname,
                                      eMAILFRIKI: _email,
                                      pASSWORDFRIKI: _password,
                                      iMAGEFRIKI:
                                          'https://www.latercera.com/resizer/bK1qdq1P1-DqP57rsOsiu4MPC34=/900x600/filters:focal(346x181:356x171)/cloudfront-us-east-1.images.arcpublishing.com/copesa/M2GBGRU4RBC7RBC26DECCE7ZAU.jpg'));
                                  Navigator.pop(context);
                                } else if (_userType == 'Organizador') {
                                  final service = OrganizerService();
                                  await service.addOrganizer(OrganizerModel(
                                      nAMEORGANIZER: _name,
                                      lASTNAMEORGANIZER: _lastname,
                                      eMAILORGANIZER: _email,
                                      pASSWORDORGANIZER: _password,
                                      iMAGEORGANIZER:
                                          'https://www.latercera.com/resizer/bK1qdq1P1-DqP57rsOsiu4MPC34=/900x600/filters:focal(346x181:356x171)/cloudfront-us-east-1.images.arcpublishing.com/copesa/M2GBGRU4RBC7RBC26DECCE7ZAU.jpg'));
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
