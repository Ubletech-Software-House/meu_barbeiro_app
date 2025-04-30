import 'package:flutter/material.dart';

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key});

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final service =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (service != null) {
      isEditing = true;
      _nameController.text = service['nome'];
      _durationController.text = service['duracao'].toString();
      _priceController.text = service['preco'].toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState?.validate() ?? false) {
      final newService = {
        'nome': _nameController.text,
        'duracao': int.tryParse(_durationController.text) ?? 0,
        'preco': double.tryParse(_priceController.text) ?? 0.0,
      };

      if (isEditing) {
        // TODO: Atualizar serviço via API
        //print('Serviço atualizado: $newService');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Serviço atualizado com sucesso!')),
        );
      } else {
        // TODO: Criar novo serviço via API
        //print('Serviço criado: $newService');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Serviço cadastrado com sucesso!')),
        );
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: Text(isEditing ? 'Editar Serviço' : 'Novo Serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Nome do serviço'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o nome';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Duração (minutos)'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Informe a duração';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Preço (R\$)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o preço';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFf39c12),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _saveService,
                child:
                    Text(isEditing ? 'Salvar Alterações' : 'Cadastrar Serviço'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
