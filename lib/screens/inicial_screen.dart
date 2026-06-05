import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider.dart';

class InicialScreen extends StatefulWidget {
  const InicialScreen({super.key});

  @override
  State<InicialScreen> createState() => _InicialScreenState();
}

class _InicialScreenState extends State<InicialScreen> {
  final TextEditingController _estadoUserCtrl = TextEditingController();
  final TextEditingController _cidadeUserCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [
            SizedBox( // logo sobe aí!
              height: 260,
              width: 200,
              child: Image.asset("assets/imagens/sobe_ai_logo.png")
            ),
            Text(
              "Sobe Aí!",
              style: Theme.of(context).textTheme.headlineLarge,
            ), // título
            // TODO: no futuro, ao invés de ser um simples input, colocar um menu de escolha com dropbox
            SizedBox( // input do Estado
              width: 250,
              height: 50,
              child: TextField( 
                controller: _estadoUserCtrl,
                decoration: InputDecoration(labelText: "Estado"),
                onChanged: (_) => setState(() {}), // para recarregar a página quando algo for digitado
              ),
            ),
            SizedBox( // input da Cidade
              width: 250,
              height: 50,
              child: TextField( 
                controller: _cidadeUserCtrl,
                decoration: InputDecoration(labelText: "Cidade"),
                onChanged: (_) => setState(() {}), // para recarregar a página quando algo for digitado
              ),
            ),
            if (_estadoUserCtrl.text.isNotEmpty && _cidadeUserCtrl.text.isNotEmpty) ...[
              IconButton( // logo sobe ai
                icon: const Icon(Icons.arrow_forward),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  userProvider.atualizarEstado(_estadoUserCtrl.text);
                  userProvider.atualizarCidade(_cidadeUserCtrl.text);

                  context.go('/');
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}