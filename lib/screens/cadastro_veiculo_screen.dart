import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';

class CadVeiculoScreen extends StatefulWidget {
  const CadVeiculoScreen({super.key});

  @override
  State<CadVeiculoScreen> createState() => _CadVeiculoScreenState();
}
  
class _CadVeiculoScreenState extends State<CadVeiculoScreen> {
  final TextEditingController _placaCtrl = TextEditingController();
  final TextEditingController _modeloCtrl = TextEditingController();
  final TextEditingController _qtdAssentosCtrl = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // para guardar as informações do usuário cadastrado
    final authProvider = Provider.of<AuthProvider>(context); // para marcar o usuário cadastrado como atual

    if (!authProvider.estaLogado) { // vai acontecer quando os botões de voltar forem disparados
      return const SizedBox.shrink();
    }

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
          onPressed: () {
            int idAtual = authProvider.user!.id; // guarda o id do cadastro motorista atual
            authProvider.logout(); // sai da conta atual -> cadastro motorista incompleto
            userProvider.removerUsuario(idAtual); // apaga as informações do cadastro do motorista -> cadastro incompleto
            context.go('/home'); // volta para página de cadastro de motorista
          },
          color: Colors.black,
        ),

        title: Text( 
            "Cadastrar Veiculo",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black, fontSize: 26),
        ),
        centerTitle: true, // para centralizar o título
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              spacing: 28,
              children: [
                SizedBox(height: 12,),
                Text(
                  "Insira as informações do seu veículo!",
                  style: TextTheme.of(context).headlineSmall?.copyWith(fontSize: 25),
                  textAlign: TextAlign.center,
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
                Text(
                  authProvider.user!.nome,
                  style: TextTheme.of(context).headlineSmall,
                ),
                SizedBox( // * input da placa
                  width: 250,
                  height: 50,
                  child: TextField( 
                    controller: _placaCtrl,
                    decoration: InputDecoration(labelText: "Placa"),
                  ),
                ), // ? Talvez adicionar algum comprovante do veículo?
                SizedBox( // * input do modelo
                  width: 250,
                  height: 50,
                  child: TextField( 
                    controller: _modeloCtrl,
                    decoration: InputDecoration(labelText: "Modelo"),
                  ),
                ), 
                Text(
                  "Quantidade de Assentos:", 
                  style: TextTheme.of(context).bodyLarge, 
                  textAlign: TextAlign.center,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        int n = int.tryParse(_qtdAssentosCtrl.text) ?? 0;
                        _qtdAssentosCtrl.text = (_qtdAssentosCtrl.text.isNotEmpty && n > 0) ? 
                        (int.parse(_qtdAssentosCtrl.text) - 1).toString()
                        : "0";
                        // checa se o campo não está vazio ou se é maior que 0
                        // Se sim: subtrai um
                        // Se não: guarda 0
                        setState(() {});
                      }, 
                      icon: Icon(Icons.minimize, size: 30,),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: _qtdAssentosCtrl,
                        textAlign: TextAlign.center,
                        inputFormatters: [ // não permite numeros negativos ou decimais
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _qtdAssentosCtrl.text = (_qtdAssentosCtrl.text.isNotEmpty) ?
                        (int.parse(_qtdAssentosCtrl.text) + 1).toString()
                        : "1";
                        setState(() {});
                      }, 
                      icon: Icon(Icons.add, size: 30,)
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox( // * Botão Cadastrar
                  height: 60,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () { // TODO criar uma função para verificar a validade dos campos
                      if (_placaCtrl.text.isNotEmpty && _modeloCtrl.text.isNotEmpty) { // se todos os campos estiverem corretos, cadastra o usuário
                        userProvider.atualizarUsuario(
                          id: authProvider.user!.id,
                          placaVeiculo: _placaCtrl.text,
                          modeloVeiculo: _modeloCtrl.text,
                          qtdAssentos: int.parse(_qtdAssentosCtrl.text),
                        ); // altera as informações do usuário
        
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
                SizedBox( // * Botão Voltar
                  height: 60,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      int idAtual = authProvider.user!.id; // guarda o id do cadastro motorista atual
                      authProvider.logout(); // sai da conta atual -> cadastro motorista incompleto
                      userProvider.removerUsuario(idAtual); // apaga as informações do cadastro do motorista -> cadastro incompleto
                      context.go('/cadastrar/motorista'); // volta para página de cadastro de motorista
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                        Expanded(
                          child: Center(child: Text("Voltar"),),
                        )
                      ],
                    ),
                  ),
                ),
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