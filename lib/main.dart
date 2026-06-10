import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // importando pacote provider para mander estado de variáveis
import 'package:go_router/go_router.dart'; // importando pacote go_router para navegar em telas

import 'providers/user_provider.dart'; // provider dos usuários
import 'providers/viagem_provider.dart'; // provider das viagens
import 'screens/inicial_screen.dart'; // tela inicial
import 'screens/home_screen.dart'; // tela principal
import 'screens/procurar_viagens_screen.dart'; // tela de busca
import 'screens/detalhes_viagem_screen.dart'; // tela de detalhes da viagem
import 'screens/sobre_screen.dart'; // tela de informações sobre o projeto
import 'screens/cadastro_passageiro_screen.dart';

void main() {
  runApp(
    MultiProvider( // configuração do provider
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ViagemProvider()),  
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final GoRouter _router = GoRouter( // configuração do go_router
    initialLocation: '/', // define página inicial
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const InicialScreen(), // classe da página da rota
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(), 
      ),
      GoRoute(
        path: '/procurar',
        builder: (context, state) => const ProcurarViagensScreen(),
      ),
      GoRoute(
        path: '/detalhes/:id', // passa o id da viagem do card que foi clicado, para ser acessado na página de detalhes
        builder: (context, state) {
          final viagemId = state.pathParameters['id']; 
          return DetalhesViagemScreen(id: viagemId);
        },
      ),
      GoRoute(
        path: '/sobre',
        builder: (context, state) => const SobreScreen(),
      ),
      GoRoute(
        path: '/cadastrar/passageiro',
        builder: (context, state) => CadPassageiroScreen(),
      ),
      // repetir a mesma estrutura para outras rotas
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Sobe Aí!",
      routerConfig: _router,
      debugShowCheckedModeBanner: false,

      scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF86B499),
        fontFamily: "Lexend",

        textTheme: const TextTheme( // TextThemes
          headlineLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight(500),
            color: Colors.white
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight(700)
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight(300)
          )
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF86B499),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontFamily: "Lexend",
              fontSize: 24,
              fontWeight: FontWeight(600)
            )
          )
        )
      ),
    );
  }
}