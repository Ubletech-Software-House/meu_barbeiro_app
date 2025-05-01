import 'package:flutter/material.dart';

class BarbershopConfigPage extends StatefulWidget {
  const BarbershopConfigPage({super.key});

  @override
  State<BarbershopConfigPage> createState() => _BarbershopConfigPageState();
}

class _BarbershopConfigPageState extends State<BarbershopConfigPage> {
  final TextEditingController _nomeController =
      TextEditingController(text: 'Barbearia Imperial');
  final TextEditingController _descricaoController = TextEditingController(
      text: 'Somos especialistas em cortes clássicos e modernos.');

  String? logoUrl; // Simulando upload

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() {
    final nome = _nomeController.text.trim();
    final descricao = _descricaoController.text.trim();

    if (nome.isEmpty || descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    // TODO: Enviar dados para API
    // print('Nome da barbearia: $nome');
    // print('Descrição: $descricao');
    // print('Logo: $logoUrl');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados da barbearia salvos com sucesso')),
    );

    Navigator.of(context).pop();
  }

  void _selecionarLogo() {
    // TODO: Simular seleção de imagem
    setState(() {
      logoUrl = 'https://via.placeholder.com/150'; // mock
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Minha Barbearia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: _selecionarLogo,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: const Color(0xFFf39c12),
                  backgroundImage:
                      logoUrl != null ? NetworkImage(logoUrl!) : null,
                  child: logoUrl == null
                      ? const Icon(Icons.camera_alt,
                          size: 36, color: Colors.white)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nomeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Nome da barbearia'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descricaoController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _salvar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Salvar Alterações'),
            )
          ],
        ),
      ),
    );
  }
}
