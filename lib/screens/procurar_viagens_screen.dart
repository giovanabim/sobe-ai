import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/viagem_provider.dart';
import '../providers/auth_provider.dart';

class ProcurarViagensScreen extends StatefulWidget {
  const ProcurarViagensScreen({super.key});

  @override
  State<ProcurarViagensScreen> createState() => _ProcurarViagensScreenState();
}

class _ProcurarViagensScreenState extends State<ProcurarViagensScreen> {
  final TextEditingController _pesquisa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viagemProvider = Provider.of<ViagemProvider>(context); // para exibir as viagens disponíveis
    final userProvider = Provider.of<AuthProvider>(context); // para saber a cidade do usuário

    final viagensFiltradas = _pesquisa.text.isEmpty // resultados do mecanismo de filtragem
    ? viagemProvider.viagens.where((viagem) => viagem.origem == userProvider.cidade).toList() 
    : viagemProvider.viagens.where((viagem) => viagem.destino.toLowerCase().contains(_pesquisa.text.trim().toLowerCase())).toList();
    // 1. verifica se a pesquisa está vazia
    // 2. Se sim: define os resultados como todas as viagens cuja origem é a mesma que a cidade o usuário
    // 3. Se não: define os resultados como todas as viagens cujo destino é o mesmo que o da pesquisa

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        // * AppBar
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,
        surfaceTintColor: Colors.transparent,

        titleSpacing: 0, // remove o espaçamento entre o title e o leading
        leadingWidth: 85, // aumenta o tamanho do leading
        leading: IconButton( // * Botão de Voltar para Home
          onPressed: () {
            context.go('/home');
          },
          icon: Icon(Icons.arrow_back, size: 42),

          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            elevation: WidgetStatePropertyAll(8.0),
            shadowColor: WidgetStatePropertyAll(Colors.black),
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
            padding: const WidgetStatePropertyAll(
              EdgeInsets.only( // define o padding dentro da searchbar
                left: 10.0,
                right: 20.0,
              ),
            ),
            trailing: [Icon(Icons.search)],
            onChanged: (_) => setState(() {}),
          ),
        ),
      ),
      body: Padding( // * Body -> Padding(ListView.builder(InkWell(Container(Padding(Column(Conteúdo))))))
        padding: EdgeInsets.only(top: 20, bottom: 5),
        child: viagensFiltradas.isEmpty // se não houver resultados
          ? SizedBox( // texto de falta de resultados
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                "Sem resultados...",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
            ),
          )
          : ListView.builder( // Cria os cards correspondentes dos resultados 
          itemCount: viagensFiltradas.length,
          itemBuilder: (BuildContext context, int index) {
            final viagem = viagensFiltradas[index];
            return InkWell( // para tornar o container clicável
              onTap: () => context.go('/detalhes/${viagem.id}'),
              child: Container( // * Template para viagens
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
                        style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            // copyWith para adicionar um estilo diferente do ThemeData
                            color: Colors.black,
                            fontWeight: FontWeight(700),
                          ),
                        textAlign: TextAlign.center,
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
            );
          },
        ),
      ),
    );
  }
}
