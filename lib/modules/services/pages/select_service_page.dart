import 'package:flutter/material.dart';

class SelectServicePage extends StatefulWidget {
  const SelectServicePage({super.key});

  @override
  State<SelectServicePage> createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> allServices = [
    {'nome': 'Corte de cabelo', 'preco': 30.0, 'duracao': 30},
    {'nome': 'Barba', 'preco': 25.0, 'duracao': 20},
    {'nome': 'Sobrancelha', 'preco': 15.0, 'duracao': 10},
  ];

  List<Map<String, dynamic>> get filteredServices {
    final query = _searchController.text.toLowerCase();
    return allServices
        .where((s) => s['nome'].toLowerCase().contains(query))
        .toList();
  }

  void _selectService(Map<String, dynamic> service) {
    Navigator.of(context).pop(service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Selecionar Serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Buscar serviço',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return Card(
                    color: const Color(0xFF2C2C2C),
                    child: ListTile(
                      title: Text(service['nome'],
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        'R\$ ${service['preco']} • ${service['duracao']} min',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      onTap: () => _selectService(service),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
