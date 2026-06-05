import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // para a integração do google maps, posição do user

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // altura da appbar
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0, // define o tamanho da sombra da appbar
        shadowColor: const Color(0xFF000000), // cor da sombra da appbar
        surfaceTintColor: Colors.transparent, // desativa o efeito de escurecer a cor de fundo

        leading: IconButton( // icone antes do titulo
          icon: const Icon(Icons.menu_rounded),
          iconSize: 44,
          onPressed: () {context.go('/');},
          color: Colors.white,
        ),

        title: Text(
            "Sobe Ai!",
            style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true, // para centralizar o título

        bottom: PreferredSize( // define o tamanho do bottom da appbar
          preferredSize: const Size.fromHeight(40.0),
          child: Container( // widget filho do bottom
            height: 40,
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ // TODO: Ao invés de ser título estático, mudar para um menu dropdown para editar a localização com facilidade
                  Icon(Icons.location_on_sharp),
                  Text( // localização escolhida pelo usuário
                    "${userProvider.cidade} - ${userProvider.estado}", 
                    style: Theme.of(context).textTheme.headlineSmall
                  )
                ],
              )
            ),
          ),
        ),
      ),
      body: Container( // placeholder para o mapa
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(child: Text("MAPA")),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 180,
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          shape: StadiumBorder(),
          label: const Text(
            "Viagens",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white
            )
          ),
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 38,
          ),
          onPressed: () {}, // * ir para página de busca
        ),
      ),
    );
  }
}