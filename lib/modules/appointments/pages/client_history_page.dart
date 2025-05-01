import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_barbeiro_app/shared/widgets/client_bottom_navbar.dart';

class ClientHistoryPage extends StatelessWidget {
  const ClientHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> agendamentos = [
      {
        'data': DateTime(2024, 5, 3, 10, 0),
        'servico': 'Corte de cabelo',
        'barbearia': 'Barbearia Imperial',
        'valor': 30.0
      },
      {
        'data': DateTime(2024, 5, 10, 14, 0),
        'servico': 'Barba completa',
        'barbearia': 'Estilo Fino',
        'valor': 25.0
      },
      {
        'data': DateTime(2024, 4, 15, 15, 0),
        'servico': 'Corte + Barba',
        'barbearia': 'Navalha de Ouro',
        'valor': 50.0
      },
    ];

    // Agrupar por mês
    final Map<String, List<Map<String, dynamic>>> agrupadoPorMes = {};
    for (var ag in agendamentos) {
      final key = DateFormat('MMMM yyyy', 'pt_BR').format(ag['data']);
      agrupadoPorMes.putIfAbsent(key, () => []).add(ag);
    }

    // Ordenar meses em ordem decrescente
    final mesesOrdenados = agrupadoPorMes.keys.toList()
      ..sort((a, b) => DateFormat('MMMM yyyy', 'pt_BR')
          .parse(b)
          .compareTo(DateFormat('MMMM yyyy', 'pt_BR').parse(a)));

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Histórico de Agendamentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: mesesOrdenados.map((mes) {
            final agendamentosMes = agrupadoPorMes[mes]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mes[0].toUpperCase() + mes.substring(1),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...agendamentosMes.map((a) => Card(
                      color: const Color(0xFF2C2C2C),
                      child: ListTile(
                        title: Text('${a['servico']} - ${a['barbearia']}',
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy • HH:mm').format(a['data']),
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Text(
                          'R\$ ${a['valor'].toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Color(0xFFf39c12),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                const SizedBox(height: 24),
              ],
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: ClientBottomNavbar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home-client');
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/profile-client');
              break;
          }
        },
      ),
    );
  }
}
