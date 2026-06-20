import 'package:flutter/material.dart';
import 'user_provider.dart';

class AuthProvider extends ChangeNotifier {
  Usuario? _user;

  String _estado = '';
  String _cidade = '';

  Usuario? get user => _user;

  String get estado => _estado;
  String get cidade => _cidade;

  bool get estaLogado =>
      _user != null;

  bool get ehVisitante =>
      _user == null;

  bool get ehPassageiro =>
      _user?.tipo ==
      UserType.passageiro;

  bool get ehMotorista =>
      _user?.tipo ==
      UserType.motorista;

  void login(Usuario usuario) {
    _user = usuario;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void definirLocalizacao({ // define a localização do usuário mesmo não logado
    required String estado,
    required String cidade,
  }) {
    _estado = estado;
    _cidade = cidade;
    notifyListeners();
  }
}