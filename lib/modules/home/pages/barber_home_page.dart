import 'package:flutter/material.dart';

class BarberHomePage extends StatelessWidget {
  const BarberHomePage({super.key});

  // Lista mock de agendamentos
  final List<Map<String, String>> appointments = const [
    {
      'cliente': 'João Silva',
      'hora': '09:00',
      'servico': 'Corte de cabelo',
    },
    {
      'cliente': 'Carlos Souza',
      'hora': '11:30',
      'servico': 'Barba + Corte',
    },
    {
      'cliente': 'Rafael Mendes',
      'hora': '14:00',
      'servico': 'Sobrancelha',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        elevation: 0,
        title: const Text(
          'Minha Agenda',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, Barbeiro 👋',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Seus agendamentos de hoje:',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final item = appointments[index];
                  return Card(
                    color: const Color(0xFF2C2C2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        '${item['hora']} - ${item['cliente']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        item['servico'] ?? '',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      leading:
                          const Icon(Icons.schedule, color: Color(0xFFf39c12)),
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
        onPressed: () {
          // TODO: navegar para tela de cadastro de serviço
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cadastrar novo serviço')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
