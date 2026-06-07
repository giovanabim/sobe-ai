import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/viagem_provider.dart';

class DetalhesViagemScreen extends StatefulWidget {
  final String? id; // guarda o id da viagem passado na página procurar_viagens_screen.dart
  const DetalhesViagemScreen({super.key, this.id});

  @override
  State<DetalhesViagemScreen> createState() => _DetalhesViagemScreenState();
}

class _DetalhesViagemScreenState extends State<DetalhesViagemScreen> {
  @override
  Widget build(BuildContext context) {
    final viagemProvider = Provider.of<ViagemProvider>(context);
    final viagem = viagemProvider.viagens[int.parse(widget.id!)]; // guarda a viagem do id mencionado

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // altura da appbar
        backgroundColor: Colors.white,
        elevation: 5.0, // define o tamanho da sombra da appbar
        shadowColor: const Color(0xFF000000), // cor da sombra da appbar
        surfaceTintColor: Colors.transparent, // desativa o efeito de escurecer a cor de fundo

        leadingWidth: 70,
        leading: IconButton( // icone antes do titulo
          icon: const Icon(Icons.arrow_back),
          iconSize: 44,
          onPressed: () {context.go('/procurar');},
          color: Colors.black,
        ),

        title: Text(
            "${viagem.origem} x ${viagem.destino}",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
        ),
        centerTitle: true, // para centralizar o título
      ),
      
      body: Stack(
        children: [
          Container( // * Placeholder do Mapa
            height: double.infinity,
            width: double.infinity,
            color: Colors.amber.shade100,
            child: Center(child: Text("MAPA"),),
          ),
          DraggableScrollableSheet( // * seção inferior que pode ser expandida
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container( // * widget da seção
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  color: Theme.of(context).primaryColor,
                ),
                child: ListView( // * conteúdo da seção
                  controller: scrollController,
                  children: [
                    Center( // Barrinha de agarrar
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          width: 100,
                          child: Divider(
                            thickness: 5,
                            color: Colors.white,
                            radius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 20),
                      child: Text(
                        "A 25 min do destino...", // ! placeholder -> DPS MUDAR HORA PARA DATETIME
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight(500),
                          color: Colors.white
                        ),
                      ),
                    ),
                    Container( // * Template para viagens
                      constraints: const BoxConstraints( // Tamanho
                        minHeight: 200,
                      ),
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),

                      decoration: BoxDecoration( // Estilo
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [ // para adicionar sombra no container
                          BoxShadow(
                            color: const Color(0x57000000),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Padding( // Conteúdo
                        padding: EdgeInsets.all(20),
                        child: Column(
                          spacing: 10,
                          children: [
                            Text( // Localidade
                              "${viagem.origem} x ${viagem.destino}",
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                // copyWith para adicionar um estilo diferente do ThemeData
                                color: Colors.black,
                                fontWeight: FontWeight(700),
                              ),
                            ),
                            Divider( // Linha separadora
                              thickness: 2,
                              color: Colors.black,
                            ),
                            Text(
                              viagem.motorista,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "${viagem.horaSaida} - ${viagem.horaChegada}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "R\$ ${viagem.preco.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              viagem.endereco,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ],
      )
    );
  }
}