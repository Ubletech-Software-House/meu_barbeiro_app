import 'package:flutter/material.dart';

class BarberSettingsPage extends StatefulWidget {
  const BarberSettingsPage({super.key});

  @override
  State<BarberSettingsPage> createState() => _BarberSettingsPageState();
}

class _BarberSettingsPageState extends State<BarberSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inicioController =
      TextEditingController(text: '08:00');
  final TextEditingController _fimController =
      TextEditingController(text: '18:00');
  final TextEditingController _intervaloController =
      TextEditingController(text: '10');

  List<String> diasSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  Set<String> diasSelecionados = {'Seg', 'Ter', 'Qua', 'Qui', 'Sex'};
  bool agendamentoOnline = true;

  @override
  void dispose() {
    _inicioController.dispose();
    _fimController.dispose();
    _intervaloController.dispose();
    super.dispose();
  }

  void _salvarConfiguracoes() {
    if (_formKey.currentState?.validate() ?? false) {
      final config = {
        'inicio': _inicioController.text,
        'fim': _fimController.text,
        'intervalo': _intervaloController.text,
        'dias': diasSelecionados.toList(),
        'agendamentoOnline': agendamentoOnline,
      };

      // TODO: Enviar config para API
      print('Configurações salvas: $config');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configurações salvas com sucesso!')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Horário de Funcionamento',
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _inicioController,
                      style: const TextStyle(color: Colors.white),
                      decoration:
                          const InputDecoration(labelText: 'Início (HH:mm)'),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Informe o início' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _fimController,
                      style: const TextStyle(color: Colors.white),
                      decoration:
                          const InputDecoration(labelText: 'Fim (HH:mm)'),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Informe o fim' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _intervaloController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Intervalo entre atendimentos (min)'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o intervalo' : null,
              ),
              const SizedBox(height: 24),
              const Text('Dias de atendimento',
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: diasSemana.map((dia) {
                  final selected = diasSelecionados.contains(dia);
                  return FilterChip(
                    label: Text(dia,
                        style: TextStyle(
                            color: selected ? Colors.black : Colors.white)),
                    selected: selected,
                    selectedColor: const Color(0xFFf39c12),
                    backgroundColor: const Color(0xFF2C2C2C),
                    onSelected: (_) {
                      setState(() {
                        if (selected) {
                          diasSelecionados.remove(dia);
                        } else {
                          diasSelecionados.add(dia);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                title: const Text('Ativar agendamento online',
                    style: TextStyle(color: Colors.white)),
                value: agendamentoOnline,
                onChanged: (value) {
                  setState(() => agendamentoOnline = value);
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarConfiguracoes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFf39c12),
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Salvar Configurações'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
