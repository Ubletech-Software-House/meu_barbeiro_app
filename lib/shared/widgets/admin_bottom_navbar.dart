import 'package:flutter/material.dart';

class AdminBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const AdminBottomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF202020),
      selectedItemColor: const Color(0xFFf39c12),
      unselectedItemColor: Colors.white70,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/admin-home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/admin-finance');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/admin-users');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/admin-plans');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/admin-settings');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.attach_money), label: 'Financeiro'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Usuários'),
        BottomNavigationBarItem(
            icon: Icon(Icons.card_membership), label: 'Planos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Configuração'),
      ],
    );
  }
}
