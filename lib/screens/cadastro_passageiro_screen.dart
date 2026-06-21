import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';

class CadPassageiroScreen extends StatefulWidget {
  const CadPassageiroScreen({super.key});

  @override
  State<CadPassageiroScreen> createState() => _CadPassageiroScreenState();
}
  
class _CadPassageiroScreenState extends State<CadPassageiroScreen> {
  final TextEditingController _nomeCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _senhaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // para guardar as informações do usuário cadastrado
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
            "Cadastrar Passageiro",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black, fontSize: 26),
        ),
        centerTitle: true, // para centralizar o título
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 28,
              children: [
                SizedBox(height: 12,),
                Text(
                  "Bem vindo(a)!",
                  style: TextTheme.of(context).headlineMedium?.copyWith(color: Colors.black),
                ),
                CircleAvatar( // * foto de perfil
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 70,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox( // * Botão de upload para foto de perfil
                  width: 235,
                  child: OutlinedButton(
                    onPressed: () {}, 
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload),
                        const Text("Escolher Foto de Perfil")
                      ],
                    )
                  ),
                ),
                SizedBox( // * input do nome
                  width: 250,
                  height: 50,
                  child: TextField( 
                    controller: _nomeCtrl,
                    decoration: InputDecoration(labelText: "Nome"),
                  ),
                ),
                SizedBox( // * input do email
                  width: 250,
                  height: 50,
                  child: TextField( 
                    controller: _emailCtrl,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                ),
                SizedBox( // * input da senha
                  width: 250,
                  height: 50,
                  child: TextField( 
                    controller: _senhaCtrl,
                    decoration: InputDecoration(labelText: "Senha"),
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
                      if (userProvider.emailJaExiste(_emailCtrl.text)) {
                        _mostrarSnackBar(context, "Esse email já está em uso.", erro: true);
                        return;
                      }
                      else if (_nomeCtrl.text.isNotEmpty && _emailCtrl.text.isNotEmpty && _senhaCtrl.text.isNotEmpty) { // se todos os campos estiverem corretos, cadastra o usuário
                        final novoUsuario = userProvider.cadastrarUsuario( // salva as informações do cadastro
                          nome: _nomeCtrl.text, 
                          email: _emailCtrl.text, 
                          senha: _senhaCtrl.text, 
                          tipo: UserType.passageiro
                        );
        
                        authProvider.login(novoUsuario); // faz login no usuário
        
                        _mostrarSnackBar(context, "Cadastro realizado com sucesso!", erro: false);
        
                        context.go('/home');
                      }
                      else {
                        _mostrarSnackBar(context, "Por favor, preencha todos os campos.", erro: true);
                        return;
                      }
                    },
                    child: Text("Cadastrar"),
                  ),
                ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: InkWell(
                    onTap: () => context.go('/login'),
                    child: Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Já possui conta?",
                          style: TextTheme.of(context).headlineSmall,
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                )
              ],
            ),
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