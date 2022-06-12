import 'package:app_flutter_frikiteam/model/UserFriki.dart';
import 'package:app_flutter_frikiteam/ui/organizer_main.dart';
import 'package:app_flutter_frikiteam/ui/register_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userTypeList = ['Usuario Friki', 'Organizador'];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  String _userType = "Tipo de usuario";
  bool _emailVerification = false;
  bool _passwordVerification = false;

  // url para obtener todos los usuarios registrados de usuario friki
  String urlFriki = "https://api-frikiteam.herokuapp.com/api/customers?offset=0&sort[sorted]=true&sort[unsorted]=true&sort[empty]=true&pageNumber=0&pageSize=0&paged=true&unpaged=true";
  String urlOrganizer = "https://api-frikiteam.herokuapp.com/api/organizers?offset=0&sort[sorted]=true&sort[unsorted]=true&sort[empty]=true&pageNumber=0&pageSize=0&paged=true&unpaged=true";

  List dataRequestFriki = [];
  List dataRequestOrganizer = [];

  Future<String> makeRequestFriki() async{
    var response = await http.get(Uri.parse(urlFriki),
        headers: {'Accept': 'application/json'});

    var extractData = json.decode(response.body);
    dataRequestFriki = extractData['content'];
    /*print("\n--USUARIOS FRIKIS--");
    for (int i = 0; i < dataRequestFriki.length; i++){
      print("Id: " + dataRequestFriki[i]["id"].toString());
      print("Usuario: " + dataRequestFriki[i]["firstName"]);
      print("Email: " + dataRequestFriki[i]["email"]);
      print("Password: " + dataRequestFriki[i]["password"]);
    }*/

    return response.body;
  }

  Future<String> makeRequestOrganizer() async{
    var response = await http.get(Uri.parse(urlOrganizer),
        headers: {'Accept': 'application/json'});
    //print(response.body);

    var extractData = json.decode(response.body);
    dataRequestOrganizer = extractData['content'];
    /*
    print("\n\n--USUARIOS ORGANIZADORES--");
    for (int i = 0; i < dataRequestOrganizer.length; i++){
      print("Id: " + dataRequestFriki[i]["id"].toString());
      print("Usuario: " + dataRequestFriki[i]["firstName"]);
      print("Email: " + dataRequestOrganizer[i]["email"]);
      print("Password: " + dataRequestOrganizer[i]["password"]);
    }*/

    return response.body;
  }

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
                              fontSize: 28,
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
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 210,
                        ),

                        TextField(
                          controller: emailController,
                          scrollPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey, width: 3),
                            ),
                            hintText: "Email",
                            fillColor: Colors.grey,
                            filled: true,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        TextField(
                          controller: passwordController,
                          scrollPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey, width: 3),
                            ),
                            hintText: "Contraseña",
                            fillColor: Colors.grey,
                            filled: true,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey, width: 3),
                            //border: const Border(color: Colors.grey, width: 3),
                          ),
                          child: DropdownButton<String>(
                            items: _userTypeList.map((String elemento){
                              return DropdownMenuItem(
                                  value: elemento,
                                  child: Text(elemento)
                              );
                            }).toList(),
                            isExpanded: true,
                            onChanged: (_value)=> {
                              setState(() {
                                //_userType es privado y almacena el valor que selecciona
                                _userType = _value!;
                              })
                            },
                            hint: Text(_userType),
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 45, right: 45),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            color: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              _email = emailController.text;
                              _password = passwordController.text;
                              print("Email: " + _email);
                              print("Password: " + _password);
                              //print("User type: " + _userType);

                              //print("Vista usuario friki");
                              if(_userType == "Usuario Friki"){

                                makeRequestFriki();
                                for (int i = 0; i < dataRequestFriki.length; i++){
                                  if(_email == dataRequestFriki[i]["email"]){
                                    _emailVerification = true;
                                  }
                                  if(_password == dataRequestFriki[i]["password"]){
                                    _passwordVerification = true;
                                  }
                                }

                                _passwordVerification && _emailVerification? Navigator.of(context).pushNamed('/friki') : print("Usuario y/o contraseña incorrectas. ");
                                _passwordVerification = _emailVerification = false;

                                //print("Vista organizador");
                              }else if (_userType == "Organizador"){

                                makeRequestOrganizer();
                                for (int i = 0; i < dataRequestOrganizer.length; i++){
                                  if(_email == dataRequestOrganizer[i]["email"]){
                                    _emailVerification = true;
                                  }
                                  if(_password == dataRequestOrganizer[i]["password"]){
                                    _passwordVerification = true;
                                  }
                                }

                                _passwordVerification && _emailVerification? Navigator.push(context, MaterialPageRoute(builder: (context) => const MainOrganizer())) : print("Usuario y/o contraseña incorrectas. ");
                                _passwordVerification = _emailVerification = false;

                              }else{
                                print("Escoga un tipo de usuario");
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 45, right: 45),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
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
                            onPressed: () {
                              //redirige al page de register
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> const RegisterPage())
                              );
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

Widget backgroundImage(){
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/backgroundApp.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}