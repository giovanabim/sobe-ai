import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider_temp.dart';

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
    final userProvider = Provider.of<UserProvider>(context);

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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
        ),
        centerTitle: true, // para centralizar o título
      ),

      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            spacing: 28,
            children: [
              SizedBox(height: 60,),
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
                  onChanged: (_) => setState(() {}), // para recarregar a página quando algo for digitado
                ),
              ),
              SizedBox( // * input do email
                width: 250,
                height: 50,
                child: TextField( 
                  controller: _emailCtrl,
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (_) => setState(() {}), // para recarregar a página quando algo for digitado
                ),
              ),
              SizedBox( // * input da senha
                width: 250,
                height: 50,
                child: TextField( 
                  controller: _senhaCtrl,
                  decoration: InputDecoration(labelText: "Senha"),
                  onChanged: (_) => setState(() {}), // para recarregar a página quando algo for digitado
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
                    if (_nomeCtrl.text.isNotEmpty && _emailCtrl.text.isNotEmpty && _senhaCtrl.text.isNotEmpty) {
                      
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
                  onTap: () => context.go('/home'),
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
    );
  }
}