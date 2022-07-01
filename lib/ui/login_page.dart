import 'package:app_flutter_frikiteam/bloc/usuario/usuario_bloc.dart';
import 'package:app_flutter_frikiteam/services/friki_service.dart';
import 'package:app_flutter_frikiteam/services/organized_service.dart';
import 'package:app_flutter_frikiteam/ui/friki_main.dart';
import 'package:app_flutter_frikiteam/ui/organizer_main.dart';
import 'package:app_flutter_frikiteam/ui/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                          height: 15,
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
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
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
                          height: 25,
                        ),
                        BlocBuilder<UsuarioBloc, UsuarioState>(
                          builder: (context, state) {
                            return Container(
                              margin: EdgeInsets.only(left: 45, right: 45),
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
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
                                onPressed: () async {
                                  _email = emailController.text;
                                  _password = passwordController.text;

                                  if (_userType == "Usuario Friki") {
                                    try {
                                      final serviceFriki = FrikiService();
                                      final user = await serviceFriki
                                          .loginFriki(_email, _password);
                                      context
                                          .read<UsuarioBloc>()
                                          .add(LoginUserEvent(user, 'friki'));
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, 'friki', ((route) => false));
                                    } catch (e) {
                                      print(e);
                                    }
                                  } else if (_userType == "Organizador") {
                                    try {
                                      final serviceOrganizer =
                                          OrganizerService();
                                      final user = await serviceOrganizer
                                          .loginOrganizer(_email, _password);
                                      print(user);
                                      context.read<UsuarioBloc>().add(
                                          LoginUserEvent(user, 'organizer'));
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          'organizer', ((route) => false));
                                    } catch (e) {
                                      print(e);
                                    }
                                  } else {
                                    print("Escoga un tipo de usuario");
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 3,
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
                            onPressed: () {
                              //redirige al page de register
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
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

Widget backgroundImage() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/backgroundApp.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}
