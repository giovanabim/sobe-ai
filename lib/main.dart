import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // importando pacote provider para mander estado de variáveis
import 'package:go_router/go_router.dart'; // importando pacote go_router para navegar em telas

import 'providers/auth_provider.dart'; // provider de checagem do login
import 'providers/user_provider.dart'; // provider dos usuários
import 'providers/viagem_provider.dart'; // provider das viagens

import 'screens/inicial_screen.dart'; // tela inicial
import 'screens/home_screen.dart'; // tela principal
import 'screens/procurar_viagens_screen.dart'; // tela de busca
import 'screens/detalhes_viagem_screen.dart'; // tela de detalhes da viagem
import 'screens/sobre_screen.dart'; // tela de informações sobre o projeto
import 'screens/login_screen.dart'; // tela de login
import 'screens/cadastro_passageiro_screen.dart'; // tela de cadastro do usuário passageiro
import 'screens/cadastro_motorista_screen.dart'; // tela de cadastro do usuário motorista
import 'screens/cadastro_veiculo_screen.dart'; // tela de cadastro do veiculo do motorista

void main() {
  runApp(
    MultiProvider( // configuração do provider
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // guarda as informações dos cadastros
        ChangeNotifierProvider(create: (_) => ViagemProvider()), // guardar as informações das viagens
        ChangeNotifierProvider(create: (_) => AuthProvider()), // guardar a informação do usuário atual
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
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/cadastrar/passageiro',
        builder: (context, state) => CadPassageiroScreen(),
      ),
      GoRoute(
        path: '/cadastrar/motorista',
        builder: (context, state) => CadMotoristaScreen(),
      ),
      GoRoute(
        path: '/cadastrar/veiculo',
        builder: (context, state) => CadVeiculoScreen(),
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
        ),
      ),
    );
  }
}