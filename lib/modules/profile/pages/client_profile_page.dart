import 'package:flutter/material.dart';
import 'package:meu_barbeiro_app/shared/widgets/client_bottom_navbar.dart';

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> cliente = {
      'nome': 'João Cliente',
      'email': 'joao@email.com',
      'telefone': '(11) 98888-8888',
      'foto': null,
    };

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Meu Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: const Color(0xFFf39c12),
                backgroundImage: cliente['foto'] != null
                    ? NetworkImage(cliente['foto'])
                    : null,
                child: cliente['foto'] == null
                    ? const Icon(Icons.person, size: 48, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            Text(cliente['nome'],
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 16),
            Text('E-mail: ${cliente['email']}',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text('Telefone: ${cliente['telefone']}',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Navegar para edição do perfil
              },
              icon: const Icon(Icons.edit),
              label: const Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Navegar para troca de senha
              },
              icon: const Icon(Icons.lock),
              label: const Text('Trocar Senha'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFf39c12)),
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClientBottomNavbar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home-client');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/history-client');
              break;
            case 2:
              break;
          }
        },
      ),
    );
  }
}
