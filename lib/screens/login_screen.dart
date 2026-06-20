import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
  
class LoginScreen extends StatelessWidget {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _senhaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context); // para marcar o usuário cadastrado como atual

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
            "Fazer Login",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black, fontSize: 26),
        ),
        centerTitle: true, // para centralizar o título
      ),

      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 28,
            children: [
              Text(
                "Bom te ver de novo!",
                style: TextTheme.of(context).headlineMedium?.copyWith(color: Colors.black),
              ),
              SizedBox( // logo sobe aí!
                height: 200,
                width: 140,
                child: Image.asset("assets/imagens/sobe_ai_logo.png")
              ),
              SizedBox(height: 10,),
              SizedBox( // * input do email
                width: 250,
                height: 50,
                child: TextField( 
                  controller: _emailCtrl,
                  decoration: InputDecoration(labelText: "Email"),
                  //onChanged: (_) => setState(() {}), // para recarregar a página quando algo for digitado
                ),
              ),
              SizedBox( // * input da senha
                width: 250,
                height: 50,
                child: TextField( 
                  controller: _senhaCtrl,
                  decoration: InputDecoration(labelText: "Senha"),
                  //onChanged: (_) => setState(() {}), // para recarregar a página quando algo for digitado
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: 180,
                child: ElevatedButton(
                  onPressed: () { // ! criar uma função para verificar a validade dos campos
                    if (_emailCtrl.text.isEmpty || _senhaCtrl.text.isEmpty) { // se algum dos campos estiver vazio
                      _mostrarSnackBar(context, "Por favor, preencha todos os campos.", erro: true);
                      return;
                    }
                    final novoUsuario = userProvider.autenticar(_emailCtrl.text, _senhaCtrl.text);
                    if (novoUsuario != null) {
                      authProvider.login(novoUsuario); // faz login no usuário
                      _mostrarSnackBar(context, "Login realizado com sucesso!", erro: false);
                      context.go('/home');
                    }
                    else {
                      _mostrarSnackBar(context, "Email ou senha incorretos.", erro: true);
                    }
                  },
                  child: Text("Entrar"),
                ),
              ),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: InkWell(
                  onTap: () => context.go('/cadastrar/passageiro'),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      Text(
                        "Não Possui conta?",
                        style: TextTheme.of(context).headlineSmall,
                      ),
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

  void _mostrarSnackBar(BuildContext context, String mensagem, {required bool erro}) { // template para os snackbars de erro
    ScaffoldMessenger.of(context).clearSnackBars();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 80,
          decoration: BoxDecoration(
            color: erro ? Colors.redAccent.shade100 : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            spacing: 10,
            children: [
              Icon(
                erro ? Icons.error_rounded : Icons.check_circle,
                color: Colors.white,
                size: 40,
              ),
              Expanded( // Evita que textos longos quebrem o layout da Row
                child: Text(
                  mensagem,
                  style: TextTheme.of(context).bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        duration: Durations.extralong3,
        behavior: SnackBarBehavior.floating, 
        backgroundColor: Colors.transparent,
        elevation: 0,                                                
      ),
    );
  }
}