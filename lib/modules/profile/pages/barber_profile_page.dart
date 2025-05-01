import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarberProfilePage extends StatelessWidget {
  const BarberProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String mesAtual = DateFormat('MMMM yyyy', 'pt_BR').format(now);
    final double faturamentoMensal = 450.0; // mock

    final Map<String, dynamic> barbeiro = {
      'nome': 'Carlos Andrade',
      'email': 'carlos@barbearia.com',
      'telefone': '(11) 99999-9999',
      'endereco': 'Rua das Tesouras, 123 - São Paulo/SP',
      'fotoUrl': null, // usar null para placeholder
    };

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Meu Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: const Color(0xFFf39c12),
                backgroundImage: barbeiro['fotoUrl'] != null
                    ? NetworkImage(barbeiro['fotoUrl'])
                    : null,
                child: barbeiro['fotoUrl'] == null
                    ? const Icon(Icons.person, size: 48, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                barbeiro['nome'],
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 32),
            Text('Faturamento em $mesAtual',
                style: const TextStyle(color: Colors.white70)),
            Text('R\$ ${faturamentoMensal.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFFf39c12),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 32),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            Text('Email: ${barbeiro['email']}',
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Telefone: ${barbeiro['telefone']}',
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Endereço: ${barbeiro['endereco']}',
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Navegar para troca de senha
              },
              icon: const Icon(Icons.lock),
              label: const Text('Trocar Senha'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/plan-details');
              },
              icon: const Icon(Icons.account_box_outlined),
              label: const Text('Ver plano contratado'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFf39c12)),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Minha Barbearia',
                  style: TextStyle(color: Colors.white)),
              subtitle: const Text('Editar nome, logo e descrição',
                  style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Colors.white70, size: 16),
              onTap: () {
                Navigator.pushNamed(context, '/barbershop-config');
              },
            ),
          ],
        ),
      ),
    );
  }
}
