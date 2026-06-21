import 'package:flutter/material.dart';

enum UserType {passageiro, motorista} // define o tipo de usuário -> afeta acesso à funções específicas

class Usuario {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final UserType tipo;

  final String? cnh;
  final String? modeloVeiculo;
  final String? placaVeiculo;
  final int? qtdAssentos;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo,

    this.cnh,
    this.modeloVeiculo,
    this.placaVeiculo,
    this.qtdAssentos,
  });

  Usuario copyWith({ // para mudar alguma informação do cadastro
    String? nome,
    String? email,
    String? senha,
    UserType? tipo,
    String? cnh,
    String? modeloVeiculo,
    String? placaVeiculo,
    int? qtdAssentos,
  }) {
    return Usuario(
      id: id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      tipo: tipo ?? this.tipo,
      cnh: cnh ?? this.cnh,
      modeloVeiculo: modeloVeiculo ?? this.modeloVeiculo,
      placaVeiculo: placaVeiculo ?? this.placaVeiculo,
      qtdAssentos: qtdAssentos ?? this.qtdAssentos,
    );
  }
}

class UserProvider extends ChangeNotifier {
  final List<Usuario> _usuarios = [
    // Conta de passageiro para testes
    Usuario(
      id: 0,
      nome: "Maria Silva",
      email: "silvamaria@gmail.com",
      senha: "123456",
      tipo: UserType.passageiro,
    ),

    // Conta de motorista para testes
    Usuario(
      id: 1,
      nome: "Wagner Nunes",
      email: "nunesvans@gmail.com",
      senha: "123456",
      tipo: UserType.motorista,
      cnh: "123456789",
      modeloVeiculo: "HB20",
      placaVeiculo: "ABC1234",
      qtdAssentos: 24,
    ),
  ];

  int _proximoId = 2;

  List<Usuario> get usuarios => List.unmodifiable(_usuarios);

  Usuario cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
    required UserType tipo,

    String? cnh,
    String? modeloVeiculo,
    String? placaVeiculo,
    int? qtdAssentos,
  }) {
    final novoUsuario = Usuario(
      id: _proximoId++,
      nome: nome,
      email: email,
      senha: senha,
      tipo: tipo,
      cnh: cnh,
      modeloVeiculo: modeloVeiculo,
      placaVeiculo: placaVeiculo,
      qtdAssentos: qtdAssentos,
    );

    _usuarios.add(novoUsuario);

    notifyListeners();

    return novoUsuario;
  }

  void removerUsuario(int id) {
    _usuarios.removeWhere((usuario) => usuario.id == id,);
    notifyListeners();
  }

  Usuario? buscarPorId(int id) {
    try {
      return _usuarios.firstWhere(
        (usuario) => usuario.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Usuario? autenticar(String email, String senha) {
    try {
      return _usuarios.firstWhere(
        (usuario) =>
            usuario.email == email &&
            usuario.senha == senha,
      );
    } catch (_) {
      return null;
    }
  }

  bool emailJaExiste(String email) {
    return _usuarios.any(
      (usuario) =>
          usuario.email.toLowerCase() ==
          email.toLowerCase(),
    );
  }

  void atualizarUsuario({
    required int id,

    String? nome,
    String? email,
    String? senha,

    UserType? tipo,

    String? cnh,
    String? modeloVeiculo,
    String? placaVeiculo,
    int? qtdAssentos,
  }) {
    final index = _usuarios.indexWhere(
      (usuario) => usuario.id == id,
    );

    if (index < 0) return;

    _usuarios[index] = _usuarios[index].copyWith(
      nome: nome,
      email: email,
      senha: senha,
      tipo: tipo,
      cnh: cnh,
      modeloVeiculo: modeloVeiculo,
      placaVeiculo: placaVeiculo,
      qtdAssentos: qtdAssentos,
    );

    notifyListeners();
  }
}