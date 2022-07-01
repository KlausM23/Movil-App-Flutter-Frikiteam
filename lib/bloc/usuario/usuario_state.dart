part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioState {
  const UsuarioState();
}

class UsuarioInitial extends UsuarioState {}

class UsuarioLoged extends UsuarioState {
  // ignore: prefer_typing_uninitialized_variables
  final usuario;
  final String typeUser;
  const UsuarioLoged(this.usuario, this.typeUser);
}
