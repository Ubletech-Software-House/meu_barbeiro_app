import 'package:flutter/material.dart';

class HomeSelectorPage extends StatelessWidget {
  const HomeSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Substituir por leitura real do usuário logado (via authProvider, localStorage, etc.)
    final String tipoUsuario = 'admin'; // mock: admin, barbeiro, cliente

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (tipoUsuario) {
        case 'admin':
          Navigator.pushReplacementNamed(context, '/admin-home');
          break;
        case 'barbeiro':
          Navigator.pushReplacementNamed(context, '/home-barber');
          break;
        case 'cliente':
        default:
          Navigator.pushReplacementNamed(context, '/home-client');
      }
    });

    return const Scaffold(
      backgroundColor: Color(0xFF202020),
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFFf39c12)),
      ),
    );
  }
}
