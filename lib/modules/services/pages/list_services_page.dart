import 'package:flutter/material.dart';

class ListServicesPage extends StatefulWidget {
  const ListServicesPage({super.key});

  @override
  State<ListServicesPage> createState() => _ListServicesPageState();
}

class _ListServicesPageState extends State<ListServicesPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> services = [
    {
      'nome': 'Corte de cabelo',
      'preco': 30.0,
      'duracao': 30,
      'ativo': true,
    },
    {
      'nome': 'Barba completa',
      'preco': 25.0,
      'duracao': 20,
      'ativo': false,
    },
    {
      'nome': 'Sobrancelha',
      'preco': 15.0,
      'duracao': 10,
      'ativo': true,
    },
  ];

  List<Map<String, dynamic>> get filteredServices {
    final query = _searchController.text.toLowerCase();
    return services
        .where((s) => s['nome'].toLowerCase().contains(query))
        .toList();
  }

  void _toggleStatus(int index) {
    setState(() {
      services[index]['ativo'] = !services[index]['ativo'];
    });
  }

  void _deleteService(int index) {
    setState(() {
      services.removeAt(index);
    });
  }

  void _editService(Map<String, dynamic> service) {
    Navigator.of(context).pushNamed(
      '/service-form',
      arguments: {
        'nome': service['nome'],
        'duracao': service['duracao'],
        'preco': service['preco'],
      },
    );
  }

  void _addService() {
    Navigator.of(context).pushNamed('/service-form');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Meus Serviços'),
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
                  final s = filteredServices[index];
                  return Card(
                    color: const Color(0xFF2C2C2C),
                    child: ListTile(
                      title: Text(
                        s['nome'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'R\$ ${s['preco']} • ${s['duracao']} min',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _editService(s),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () => _deleteService(index),
                          ),
                          IconButton(
                            icon: Icon(
                              s['ativo']
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white54,
                            ),
                            onPressed: () => _toggleStatus(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFf39c12),
        onPressed: _addService,
        child: const Icon(Icons.add),
      ),
    );
  }
}
