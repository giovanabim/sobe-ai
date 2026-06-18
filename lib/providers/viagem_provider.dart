import 'package:flutter/material.dart';

class Viagem { // classe para guardar as viagens (temporário enquanto não há banco de dados)
  final int id;
  final String origem;
  final String destino;
  final String motorista;
  final double preco;
  final String horaSaida; // TODO: utilizar o tipo DateTime para guardar essas informações
  final String horaChegada;   // TODO: utilizar o tipo DateTime para guardar essas informações
  final String endereco;

  Viagem({ // função construtura
    required this.id,
    required this.origem,
    required this.destino,
    required this.motorista,
    required this.preco,
    required this.horaSaida,
    required this.horaChegada,
    required this.endereco,
  });

  Viagem copyWith({ // para mudar os atributos das instâncias após sua criação
    String? origem,
    String? destino,
    String? motorista,
    double? preco,
    String? horaSaida,
    String? horaChegada,
    String? endereco,
  }) {
    return Viagem(
      id: id,
      origem: origem ?? this.origem,
      destino: destino ?? this.destino,
      motorista: motorista ?? this.motorista,
      preco: preco ?? this.preco,
      horaSaida: horaSaida ?? this.horaSaida,
      horaChegada: horaChegada ?? this.horaChegada,
      endereco: endereco ?? this.endereco,
    );
  }
}

class ViagemProvider extends ChangeNotifier {
  final List<Viagem> _viagens = [
    Viagem( // Exemplo 1
      id: 0,
      origem: "Cidade1",
      destino: "Cidade2",
      motorista: "Wagner Nunes",
      preco: 35.00,
      horaSaida: "16:30",
      horaChegada: "18:30",
      endereco: "R. Alegre 123, Bairro"
    ),
    Viagem( // Exemplo 2
      id: 1,
      origem: "Cidade3",
      destino: "Cidade2",
      motorista: "Luís Alencar",
      preco: 30.00,
      horaSaida: "08:00",
      horaChegada: "10:00",
      endereco: "R. Alegre 123, Bairro"
    ),
    Viagem( // Exemplo 3
      id: 2,
      origem: "Cidade2",
      destino: "Cidade4",
      motorista: "Wagner Nunes",
      preco: 35.00,
      horaSaida: "16:30",
      horaChegada: "18:30",
      endereco: "R. Alegre 123, Bairro, Cidade, Estado, Complemento"
    ),
    Viagem( // Exemplo 4
      id: 3,
      origem: "Cidade4",
      destino: "Cidade1",
      motorista: "Luís Alencar",
      preco: 30.00,
      horaSaida: "08:00",
      horaChegada: "10:00",
      endereco: "R. Alegre 123, Bairro"
    ),
  ];

  int _proximoId = 3;

  List<Viagem> get viagens => List.unmodifiable(_viagens);

  void adicionarViagem({
    required String origem,
    required String destino,
    required String motorista,
    required double preco,
    required String horaSaida,
    required String horaChegada,
    required String endereco,
  }) {
    _viagens.add(
      Viagem(
        id: _proximoId++, // define o id automaticamente com uma contagem crescente (não dinâmico)
        origem: origem,
        destino: destino,
        motorista: motorista,
        preco: preco,
        horaSaida: horaSaida,
        horaChegada: horaChegada,
        endereco: endereco,
      ),
    );

    notifyListeners();
  }

  void removerViagem(int id) {
    _viagens.removeWhere((viagem) => viagem.id == id);
    notifyListeners();
  }

  void atualizarViagem({ // função para modificar a viagem por meio do provider
    required int id, // o id é necessário para saber qual viagem modificar
    String? origem, // o ? representa que o atributo não é um parâmetro especificamente necessário
    String? destino,
    String? motorista,
    double? preco,
    String? horaSaida,
    String? horaChegada,
    String? endereco,
  }) {
    final index = _viagens.indexWhere( // procura dentro da lista de viagens o índice da viagem que possui o mesmo id que o informado
      (viagem) => viagem.id == id
    );

    if (index < 0) return;

    _viagens[index] = _viagens[index].copyWith(
      origem: origem,
      destino: destino,
      motorista: motorista,
      preco: preco,
      horaSaida: horaSaida,
      horaChegada: horaChegada,
      endereco: endereco,
    );
    notifyListeners();

    // Uso do código:
    // provider.atualizarViagem(
    //  id: 1,
    //  preco: 35.50,
    // );
  }
}