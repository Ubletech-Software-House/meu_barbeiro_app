import 'package:flutter/material.dart';

class BarbershopDetailsPage extends StatelessWidget {
  const BarbershopDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> barbearia =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: Text(barbearia['nome'], overflow: TextOverflow.ellipsis),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFf39c12),
                backgroundImage: barbearia['foto'] != null
                    ? NetworkImage(barbearia['foto'])
                    : null,
                child: barbearia['foto'] == null
                    ? const Icon(Icons.person, size: 48, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${barbearia['nota']} ⭐',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Descrição:',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              barbearia['descricao'],
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text('Serviços:',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 8),
            ...barbearia['servicos']
                .map<Widget>((s) =>
                    Text('• $s', style: const TextStyle(color: Colors.white)))
                .toList(),
            const SizedBox(height: 24),
            const Text('Endereço:',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              barbearia['endereco'],
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Ir para agendamento desta barbearia
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Agendar'),
            )
          ],
        ),
      ),
    );
  }
}
