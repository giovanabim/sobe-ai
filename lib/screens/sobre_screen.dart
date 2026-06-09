import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  final texto = """Em muitas comunidades do interior, a locomoção entre diferentes localidades é um desafio diário. A ausência de transporte público regular e acessível faz com que os moradores dependam de caronas informais ou veículos que circulam em horários limitados.
O Sobe aí! tem o objetivo de conectar pessoas que precisam se deslocar de um lugar ao outro por meio de vans a motoristas que realizam os mesmos trajetos.""";

  Widget _fotoItem(BuildContext context) { // * cards com foto e nome do membro da equipe
    return SizedBox(
      child: Column(
        spacing: 10,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor
            ),
            child: Icon(Icons.person, color: Colors.white, size: 50,),
          ),
          Text(
            "Nome",
            style: TextTheme.of(context).headlineSmall
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {context.go('/home');},
          color: Colors.black,
        ),

        title: Text( 
            "Sobre",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
        ),
        centerTitle: true, // para centralizar o título
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 50,
          children: [
            Text( // * texto informativo
              texto, 
              textAlign: TextAlign.center,
              style: TextTheme.of(context).bodyLarge,  
            ),
            Text( // * Subtítulo 
              "Nosso Time", 
              style: TextTheme.of(context).headlineMedium?.copyWith(color: Colors.black),
            ),
            SizedBox( // * Grade com fotos dos membros
              height: 350,
              width: double.infinity,
              child: Column(
                spacing: 40,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      _fotoItem(context),
                      _fotoItem(context),
                      _fotoItem(context)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      _fotoItem(context),
                      _fotoItem(context)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}