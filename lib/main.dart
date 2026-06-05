import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // importando pacote provider para mander estado de variáveis
import 'package:go_router/go_router.dart'; // importando pacote go_router para navegar em telas

import 'providers/user_provider.dart';
import 'screens/inicial_screen.dart'; // tela inicial
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider( // configuração do provider
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
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
        builder: (context, state) => const HomeScreen(), // classe da página da rota
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
        ),
      ),
    );
  }
}
