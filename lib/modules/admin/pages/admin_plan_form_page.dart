import 'package:flutter/material.dart';

class AdminPlanFormPage extends StatefulWidget {
  final Map<String, dynamic>? planoExistente;

  const AdminPlanFormPage({super.key, this.planoExistente});

  @override
  State<AdminPlanFormPage> createState() => _AdminPlanFormPageState();
}

class _AdminPlanFormPageState extends State<AdminPlanFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _valorController;
  late TextEditingController _descricaoController;

  bool suporteTicket = false;
  bool suporteWhatsApp = false;
  bool suporteCall = false;

  @override
  void initState() {
    super.initState();

    final plano = widget.planoExistente;
    _nomeController = TextEditingController(text: plano?['nome'] ?? '');
    _valorController =
        TextEditingController(text: plano?['valor']?.toString() ?? '');
    _descricaoController =
        TextEditingController(text: plano?['descricao'] ?? '');
    suporteTicket = plano?['ticket'] ?? false;
    suporteWhatsApp = plano?['whatsapp'] ?? false;
    suporteCall = plano?['call'] ?? false;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _valorController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvarPlano() {
    if (_formKey.currentState?.validate() ?? false) {
      final novoPlano = {
        'nome': _nomeController.text.trim(),
        'valor': double.tryParse(_valorController.text.trim()) ?? 0.0,
        'descricao': _descricaoController.text.trim(),
        'ticket': suporteTicket,
        'whatsapp': suporteWhatsApp,
        'call': suporteCall,
      };

      //print('Plano salvo: $novoPlano');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plano salvo com sucesso!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final plano = widget.planoExistente ?? arguments;

    if (plano != null && _nomeController.text.isEmpty) {
      _nomeController.text = plano['nome'];
      _valorController.text = plano['valor'].toString();
      _descricaoController.text = plano['descricao'];
      suporteTicket = plano['ticket'] ?? false;
      suporteWhatsApp = plano['whatsapp'] ?? false;
      suporteCall = plano['call'] ?? false;
    }

    final bool editando = widget.planoExistente != null;

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: Text(editando ? 'Editar Plano' : 'Novo Plano'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Nome do plano'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o nome do plano' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valorController,
                style: const TextStyle(color: Colors.white),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Valor mensal'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o valor' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration:
                    const InputDecoration(labelText: 'Descrição do plano'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Suportes disponíveis:',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                value: suporteTicket,
                onChanged: (v) => setState(() => suporteTicket = v),
                title: const Text('Suporte via Ticket',
                    style: TextStyle(color: Colors.white)),
              ),
              SwitchListTile(
                value: suporteWhatsApp,
                onChanged: (v) => setState(() => suporteWhatsApp = v),
                title: const Text('Suporte via WhatsApp',
                    style: TextStyle(color: Colors.white)),
              ),
              SwitchListTile(
                value: suporteCall,
                onChanged: (v) => setState(() => suporteCall = v),
                title: const Text('Suporte por ligação (Call)',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarPlano,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFf39c12),
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
