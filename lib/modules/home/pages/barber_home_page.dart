import 'package:flutter/material.dart';
import 'package:meu_barbeiro_app/shared/widgets/barber_bottom_navbar.dart';

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
          Navigator.of(context).pushNamed('/create-appointment');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BarberBottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home-barber');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/appointments');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/services');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}
