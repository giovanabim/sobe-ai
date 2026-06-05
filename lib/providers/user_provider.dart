import 'package:flutter/material.dart';

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

  String _estado = "";
  String _cidade = "";

  String get estado => _estado;
  String get cidade => _cidade;

  set estado(String valor) {
    _estado = valor;
    notifyListeners();
  }
  set cidade(String valor) {
    _cidade = valor;
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