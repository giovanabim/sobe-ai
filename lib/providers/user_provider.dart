import 'package:flutter/material.dart';

enum UserType {
  visitante,
  passageiro,
  motorista
}

class UserProvider extends ChangeNotifier {
  // Para referencia:
  // tipo _nome = valor;
  // tipo get nome => _nome;
  // set nome(tipo valor) {
  //    _nome = valor;
  //    notifyListeners();
  // }
  // void atualizarNome(tipo novoValor) {
  //    _nome = novoValor;
  //    notifyListeners();   
  // }

  // Variáveis da Página Inicial
  UserType _tipo = UserType.visitante;

  String _nome = "Teste";
  String _estado = "";
  String _cidade = "";

  UserType get tipo => _tipo;

  String get nome => _nome;
  String get estado => _estado;
  String get cidade => _cidade;

  set tipo(UserType tipo) {
    _tipo = tipo;
    notifyListeners();
  }

  set nome(String valor) {
    _nome = valor.trim();
    notifyListeners();
  }
  set estado(String valor) {
    _estado = valor;
    notifyListeners();
  }
  set cidade(String valor) {
    _cidade = valor;
    notifyListeners();
  }

  void atualizarTipo(UserType novoTipo) {
    _tipo = novoTipo;
    notifyListeners();
  }

  void atualizarNome(String novoNome) {
    _nome = novoNome;
    notifyListeners();
  }
  void atualizarEstado(String novoEstado) {
    _estado = novoEstado;
    notifyListeners();
  }
  void atualizarCidade(String novaCidade) {
    _cidade = novaCidade;
    notifyListeners();
  }
}

class PassageiroProvider extends ChangeNotifier {
  final UserProvider user;

  PassageiroProvider(this.user) {
    user.tipo = UserType.passageiro;
  }
}

class MotoristaProvider extends ChangeNotifier {
  final UserProvider user;

  MotoristaProvider(this.user) {
    user.tipo = UserType.motorista;
  }
}