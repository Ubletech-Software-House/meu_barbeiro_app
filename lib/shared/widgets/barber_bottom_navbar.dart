import 'package:flutter/material.dart';

class BarberBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BarberBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF202020),
      selectedItemColor: const Color(0xFFf39c12),
      unselectedItemColor: Colors.white70,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Agenda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cut),
          label: 'Serviços',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
    );
  }
}
