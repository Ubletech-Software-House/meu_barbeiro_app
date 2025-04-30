import 'package:flutter/material.dart';

class HomeSelectorPage extends StatelessWidget {
  const HomeSelectorPage({super.key});

  // Simulação de perfil — depois você vai pegar isso da API ou local storage
  final String userProfile = 'cliente'; // ou 'barbeiro'

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userProfile == 'barbeiro') {
        Navigator.pushReplacementNamed(context, '/home-barber');
      } else {
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
