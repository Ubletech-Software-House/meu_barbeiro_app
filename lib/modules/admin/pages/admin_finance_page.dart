import 'package:flutter/material.dart';
import 'package:meu_barbeiro_app/shared/widgets/admin_bottom_navbar.dart';

class AdminFinancePage extends StatelessWidget {
  const AdminFinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock de valores financeiros
    final double valorPrevisto = 1897.70;
    final double valorRecebido = 1248.60;

    // Mock de barbeiros e status de pagamento
    final List<Map<String, dynamic>> barbeiros = [
      {
        'nome': 'Carlos Andrade',
        'plano': 'Barber Pro',
        'valor': 49.90,
        'status': 'pago'
      },
      {
        'nome': 'Luana Corte',
        'plano': 'Barber Lite',
        'valor': 19.90,
        'status': 'pendente'
      },
      {
        'nome': 'João Fino',
        'plano': 'Barber Pro',
        'valor': 49.90,
        'status': 'pago'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Financeiro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFF2C2C2C),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resumo do mês',
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Previsto: R\$ ${valorPrevisto.toStringAsFixed(2)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 4),
                    Text('Recebido: R\$ ${valorRecebido.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xFFf39c12),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Barbeiros por plano',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: barbeiros.length,
                itemBuilder: (context, index) {
                  final b = barbeiros[index];
                  return Card(
                    color: const Color(0xFF2C2C2C),
                    child: ListTile(
                      title: Text(b['nome'],
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text('Plano: ${b['plano']}',
                          style: const TextStyle(color: Colors.white70)),
                      trailing: Text(
                        b['status'] == 'pago' ? 'Pago' : 'Pendente',
                        style: TextStyle(
                          color: b['status'] == 'pago'
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(currentIndex: 1),
    );
  }
}
