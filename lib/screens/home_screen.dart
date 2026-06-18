import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // altura da appbar
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0, // define o tamanho da sombra da appbar
        shadowColor: const Color(0xFF000000), // cor da sombra da appbar
        surfaceTintColor: Colors.transparent, // desativa o efeito de escurecer a cor de fundo

        leadingWidth: 70,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton( // icone antes do titulo
              icon: const Icon(Icons.menu_rounded),
              iconSize: 44,
              onPressed: Scaffold.of(context).openDrawer,
              color: Colors.white,
            );
          },
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

      drawer: Drawer( // * Menu
        backgroundColor: Colors.white,
        width: 350,
        child: ListView(
          children: [
            SizedBox(
              height: 110,
              child: InkWell(
                focusColor: Theme.of(context).hoverColor,
                onTap: () => context.go('/'),
                child: DrawerHeader( 
                  margin: EdgeInsets.only(bottom: 0),
                  child: Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 35,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      if (userProvider.user == null) ...[ // se não estiver logado
                        Row(
                          spacing: 5,
                          children: [
                            Text(
                              "Fazer Login",
                              style: Theme.of(context).textTheme.headlineSmall   
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      ]
                      else ... [ // se estiver logado 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProvider.user!.nome,
                              style: Theme.of(context).textTheme.headlineSmall   
                            ),
                            Text(
                              userProvider.user!.email,
                              style: Theme.of(context).textTheme.bodyMedium,   
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text("Procurar Viagens"),
              onTap: () => context.go('/procurar'),
            ),
            ListTile( 
              leading: const Icon(Icons.question_mark_outlined),
              title: const Text("Sobre"),
              onTap: () => context.go('/sobre'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sair"),
              onTap: () => context.go('/'),
            )
          ],
        ),
      ),

      body: Container( // placeholder para o mapa
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber.shade100,
        child: Center(child: Text("MAPA")),
      ),

      floatingActionButton: SizedBox( // leva para a página de busca
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
          onPressed: () {context.go('/procurar');}, 
        ),
      ),
    );
  }
}