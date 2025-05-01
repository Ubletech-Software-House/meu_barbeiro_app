import 'package:flutter/material.dart';
import 'package:meu_barbeiro_app/shared/widgets/admin_bottom_navbar.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  List<Map<String, dynamic>> usuarios = [
    {
      'nome': 'João Cliente',
      'email': 'joao@email.com',
      'tipo': 'cliente',
      'ativo': true,
    },
    {
      'nome': 'Carlos Barbeiro',
      'email': 'carlos@barbearia.com',
      'tipo': 'barbeiro',
      'ativo': true,
    },
    {
      'nome': 'Luana Corte',
      'email': 'luana@barber.com',
      'tipo': 'barbeiro',
      'ativo': false,
    },
  ];

  void _alternarStatus(int index) {
    setState(() {
      usuarios[index]['ativo'] = !usuarios[index]['ativo'];
    });
  }

  Widget _badgeTipo(String tipo) {
    final cor = tipo == 'cliente' ? Colors.blueAccent : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tipo[0].toUpperCase() + tipo.substring(1),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Usuários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            final u = usuarios[index];
            return Card(
              color: const Color(0xFF2C2C2C),
              child: ListTile(
                title: Text(u['nome'],
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(u['email'],
                    style: const TextStyle(color: Colors.white70)),
                leading: _badgeTipo(u['tipo']),
                trailing: IconButton(
                  icon: Icon(
                    u['ativo'] ? Icons.toggle_on : Icons.toggle_off,
                    color: u['ativo'] ? Colors.greenAccent : Colors.grey,
                    size: 32,
                  ),
                  onPressed: () => _alternarStatus(index),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const AdminBottomNavbar(currentIndex: 2),
    );
  }
}
