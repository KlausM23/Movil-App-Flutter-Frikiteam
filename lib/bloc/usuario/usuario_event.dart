part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioEvent {}

class LoginUserEvent extends UsuarioEvent {
  // ignore: prefer_typing_uninitialized_variables
  final usuario;
  final String typeUser;
  LoginUserEvent(this.usuario, this.typeUser);
}
