import 'package:flutter/material.dart';
import 'package:meu_barbeiro_app/shared/widgets/admin_bottom_navbar.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chamados = [
      {
        'titulo': 'Erro ao agendar',
        'tipo': 'Ticket',
        'prioridade': 2,
        'status': 'aberto',
        'data': DateTime(2024, 5, 10, 14, 0),
      },
      {
        'titulo': 'Plano não ativado',
        'tipo': 'WhatsApp',
        'prioridade': 1,
        'status': 'aberto',
        'data': DateTime(2024, 5, 12, 10, 0),
      },
      {
        'titulo': 'Dúvida sobre cobrança',
        'tipo': 'Call',
        'prioridade': null,
        'status': 'aberto',
        'data': DateTime(2024, 5, 9, 11, 0),
      },
      {
        'titulo': 'Problema com perfil',
        'tipo': 'Ticket',
        'prioridade': 3,
        'status': 'resolvido',
        'data': DateTime(2024, 5, 8, 9, 0),
      },
      {
        'titulo': 'Acesso negado',
        'tipo': 'Call',
        'prioridade': null,
        'status': 'aberto',
        'data': DateTime(2024, 5, 13, 15, 0),
      },
    ];

    final List<Map<String, dynamic>> naoResolvidos =
        chamados.where((c) => c['status'] != 'resolvido').toList()
          ..sort((a, b) {
            final priA = a['prioridade'] ?? 99;
            final priB = b['prioridade'] ?? 99;
            if (priA != priB) return priA.compareTo(priB);
            return (b['data'] as DateTime).compareTo(a['data'] as DateTime);
          });

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        title: const Text('Administração'),
        backgroundColor: const Color(0xFF202020),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Últimos chamados de suporte',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: naoResolvidos.take(5).length,
                itemBuilder: (context, index) {
                  final c = naoResolvidos[index];
                  return Card(
                    color: const Color(0xFF2C2C2C),
                    child: ListTile(
                      title: Text(
                        c['titulo'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${c['tipo']} • ${c['status'].toString().toUpperCase()} • ${c['data'].day}/${c['data'].month} ${c['data'].hour}:${c['data'].minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: c['prioridade'] != null
                          ? Text('P${c['prioridade']}',
                              style: const TextStyle(
                                  color: Color(0xFFf39c12),
                                  fontWeight: FontWeight.bold))
                          : const SizedBox(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin-support');
                },
                icon: const Icon(Icons.support_agent),
                label: const Text('Ver todos os chamados'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFf39c12)),
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminBottomNavbar(currentIndex: 0),
    );
  }
}
