import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanDetailsPage extends StatelessWidget {
  const PlanDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plano = {
      'nome': 'Plano Profissional',
      'valor': 49.90,
      'vencimento': DateTime(2024, 5, 15),
    };

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Plano Contratado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Seu plano atual:',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 8),
            Text(plano['nome'],
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 24),
            const Text('Valor mensal:',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            Text('R\$ ${plano['valor'].toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Color(0xFFf39c12),
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('Data de vencimento:',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            Text(
              DateFormat('dd/MM/yyyy').format(plano['vencimento']),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar upgrade
              },
              icon: const Icon(Icons.trending_up),
              label: const Text('Upgrade de Plano'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Implementar downgrade
              },
              icon: const Icon(Icons.trending_down),
              label: const Text('Downgrade de Plano'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFf39c12)),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
