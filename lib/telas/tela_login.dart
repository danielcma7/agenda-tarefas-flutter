import 'package:flutter/material.dart';
import '../cores.dart';
import '../dados/memoria.dart';
import '../widgets/cabecalho_icone.dart';
import 'tela_cadastro.dart';
import 'tela_calendario.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final emailCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  void entrar() {
    String email = emailCtrl.text.trim();
    String senha = senhaCtrl.text;

    if (email.isEmpty || senha.isEmpty) {
      aviso('Preencha email e senha');
      return;
    }

    for (var u in usuarios) {
      if (u.email == email && u.senha == senha) {
        usuarioLogado = u;
        senhaCtrl.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TelaCalendario()),
        );
        return;
      }
    }
    aviso('Email ou senha incorretos');
  }

  void aviso(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
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
            const CabecalhoIcone(),
            Expanded(
              child: Container(
                width: double.infinity,
                color: roxo,
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('Email', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 4),
                      TextField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 14),
                      const Text('Senha', style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 4),
                      TextField(controller: senhaCtrl, obscureText: true),
                      const SizedBox(height: 24),
                      ElevatedButton(onPressed: entrar, child: const Text('Entrar')),
                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            const Text('Não é cadastrado?',
                                style: TextStyle(color: Colors.white)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const TelaCadastro()),
                                );
                              },
                              child: const Text(
                                'Cadastre-se',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
