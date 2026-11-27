import 'package:flutter/material.dart';
import '../cores.dart';
import '../dados/memoria.dart';
import '../models/usuario.dart';
import '../widgets/cabecalho_icone.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final nomeCtrl = TextEditingController();
  final raCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  void cadastrar() {
    String nome = nomeCtrl.text.trim();
    String ra = raCtrl.text.trim();
    String email = emailCtrl.text.trim();
    String senha = senhaCtrl.text;

    if (nome.isEmpty || ra.isEmpty || email.isEmpty || senha.isEmpty) {
      aviso('Preencha todos os campos');
      return;
    }
    if (!email.contains('@')) {
      aviso('Email inválido');
      return;
    }
    if (senha.length < 4) {
      aviso('A senha precisa ter pelo menos 4 caracteres');
      return;
    }
    if (usuarios.any((u) => u.email == email)) {
      aviso('Esse email já está cadastrado');
      return;
    }

    usuarios.add(Usuario(nome, ra, email, senha));
    aviso('Cadastro feito! Agora é só entrar');
    Navigator.pop(context);
  }

  void aviso(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget campo(String label, TextEditingController ctrl,
      {bool senha = false, TextInputType tipo = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          TextField(controller: ctrl, obscureText: senha, keyboardType: tipo),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nomeCtrl.dispose();
    raCtrl.dispose();
    emailCtrl.dispose();
    senhaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                const CabecalhoIcone(),
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: roxoEscuro),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: roxo,
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('CADASTRO',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      campo('Nome', nomeCtrl),
                      campo('RA', raCtrl, tipo: TextInputType.number),
                      campo('Email', emailCtrl, tipo: TextInputType.emailAddress),
                      campo('Senha', senhaCtrl, senha: true),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: cadastrar, child: const Text('Cadastrar')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
