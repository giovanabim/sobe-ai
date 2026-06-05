import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ProcurarViagensScreen extends StatefulWidget {
  const ProcurarViagensScreen({super.key});

  @override
  State<ProcurarViagensScreen> createState() => _ProcurarViagensScreenState();
}

class _ProcurarViagensScreenState extends State<ProcurarViagensScreen> {
  final TextEditingController _pesquisa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final motoristaProvider... -> Para aparecer as viagens

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar( // * AppBar
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,

        titleSpacing: 0, // remove o espaçamento entre o title e o leading
        leadingWidth: 85, // aumenta o tamanho do leading
        leading: IconButton( // * Botão de Voltar para Home
          onPressed: () {context.go('/home');}, 
          icon: Icon(
            Icons.arrow_back,
            size: 42,
          ),
          
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            elevation: WidgetStatePropertyAll(8.0),
            shadowColor: WidgetStatePropertyAll(Colors.black)
        //  side: WidgetStatePropertyAll(BorderSide( -> como adicionar borda (Só para referência futura)
        //    color: Colors.black,
        //    width: 2.0
        //  )),
          ),
        ),

        title: Padding( // * Barra de Pesquisa
          padding: EdgeInsets.only(right: 16.0),
          child: SearchBar(
            controller: _pesquisa,
            hintText: "Procurar viagens...",

            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            padding: const WidgetStatePropertyAll(EdgeInsets.only( // define o padding dentro da searchbar
              left: 10.0, right: 20.0,)
            ),
            trailing: [
              Icon(Icons.search),   
            ],
            onChanged: (_) => setState(() {}),
          ),
        ),
      ),
      body: Center( // * Body -> [Center(Padding(Column(Container(Conteúdos da viagem))))]
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
          child: Column(
            spacing: 10,
            children: [
              Container( // * Template para viagens
                constraints: const BoxConstraints( // Tamanho
                  minHeight: 200,
                ),
                width: double.infinity,

                decoration: BoxDecoration( // Estilo
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [ // para adicionar sombra no container
                    BoxShadow(
                      color: const Color(0x57000000),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 6)
                    ),
                  ]
                ),

                child: Padding( // Conteúdo
                  padding: EdgeInsets.all(20),
                  child: Column(
                    spacing: 10,
                    children: [
                      Text( // Localidade
                        "Origem x Destino", 
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith( // copyWith para adicionar um estilo diferente do ThemeData
                          color: Colors.black,
                          fontWeight: FontWeight(700),
                        ),
                      ),
                      Container( // Linha separadora
                        height: 2,
                        color: Colors.black,
                      ),
                      Text("Nome do Motorista", style: Theme.of(context).textTheme.titleMedium,),
                      Text("00:00 - 00:00", style: Theme.of(context).textTheme.titleLarge,),
                      Text("R\$ 00,00", style: Theme.of(context).textTheme.titleMedium,),
                      Text("Rua sei lá oq, 321, João de Deus, Petrolina-PE", 
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}