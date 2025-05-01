import 'package:flutter/material.dart';
import 'package:meu_barbeiro_app/shared/widgets/admin_bottom_navbar.dart';

class AdminPlansPage extends StatelessWidget {
  const AdminPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> planos = [
      {
        'nome': 'Básico',
        'valor': 19.90,
        'ativo': true,
        'barbeiros': 12,
      },
      {
        'nome': 'Profissional',
        'valor': 49.90,
        'ativo': true,
        'barbeiros': 27,
      },
      {
        'nome': 'Premium',
        'valor': 89.90,
        'ativo': false,
        'barbeiros': 5,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Planos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/admin-plan-form');
            },
            icon: const Icon(Icons.add),
            tooltip: 'Novo Plano',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: planos.length,
          itemBuilder: (context, index) {
            final plano = planos[index];
            return Card(
              color: const Color(0xFF2C2C2C),
              child: ListTile(
                title: Text(plano['nome'],
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text('R\$ ${plano['valor'].toStringAsFixed(2)} / mês',
                    style: const TextStyle(color: Colors.white70)),
                leading: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: plano['ativo'] ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    plano['ativo'] ? 'Ativo' : 'Inativo',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chip(
                      label: Text(
                        '${plano['barbeiros']} usuários',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/admin-plan-form',
                          arguments: plano,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        plano['ativo'] ? Icons.block : Icons.check_circle,
                        color: plano['ativo']
                            ? Colors.redAccent
                            : Colors.greenAccent,
                      ),
                      onPressed: () {
                        // TODO: Ativar/Inativar plano
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(currentIndex: 3),
    );
  }
}
