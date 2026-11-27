import 'package:flutter/material.dart';
import '../cores.dart';
import '../dados/memoria.dart';
import '../models/tarefa.dart';
import '../widgets/cabecalho_usuario.dart';

class TelaTarefas extends StatefulWidget {
  final DateTime dia;

  const TelaTarefas({super.key, required this.dia});

  @override
  State<TelaTarefas> createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas> {
  late List<Tarefa> lista;

  @override
  void initState() {
    super.initState();
    lista = tarefasDoDia(widget.dia);
    ordenar();
  }

  // pendentes primeiro, depois as concluidas, as duas em ordem alfabetica
  void ordenar() {
    lista.sort((a, b) {
      if (a.concluida != b.concluida) {
        return a.concluida ? 1 : -1;
      }
      return a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase());
    });
  }

  void adicionar(String titulo) {
    setState(() {
      lista.add(Tarefa(titulo));
      ordenar();
    });
  }

  void marcar(Tarefa t, bool? valor) {
    setState(() {
      t.concluida = valor ?? false;
      ordenar();
    });
  }

  void remover(Tarefa t) {
    setState(() => lista.remove(t));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${t.titulo}" removida')),
    );
  }

  void abrirDialog() {
    final ctrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(),
          title: const Text('Nova tarefa'),
          content: TextField(
            controller: ctrl,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Descrição da tarefa'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  String texto = ctrl.text.trim();
                  if (texto.isEmpty) return;
                  adicionar(texto);
                  Navigator.pop(ctx);
                },
                child: const Text('Adicionar tarefa'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget itemTarefa(Tarefa t) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(width: 10, height: 10, color: t.concluida ? verde : azul),
          Checkbox(
            value: t.concluida,
            activeColor: verde,
            onChanged: (v) => marcar(t, v),
          ),
          Expanded(
            child: Text(
              t.titulo,
              style: TextStyle(
                fontSize: 15,
                color: t.concluida ? Colors.black45 : Colors.black87,
                decoration: t.concluida ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () => remover(t),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int pendentes = lista.where((t) => !t.concluida).length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CabecalhoUsuario(
              subtitulo: 'Dia ${formatarData(widget.dia)}',
              botao: IconButton(
                icon: const Icon(Icons.calendar_month, color: roxoEscuro),
                tooltip: 'Voltar pro calendário',
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: roxo,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dia ${formatarData(widget.dia)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$pendentes pendente(s) - ${lista.length - pendentes} concluída(s)',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: lista.isEmpty
                            ? const Center(
                                child: Text('Nenhuma tarefa nesse dia',
                                    style: TextStyle(color: Colors.black45)),
                              )
                            : ListView(
                                children: lista.map(itemTarefa).toList(),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: InkWell(
                        onTap: abrirDialog,
                        child: Container(
                          width: 56,
                          height: 56,
                          color: roxoEscuro,
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 32),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
