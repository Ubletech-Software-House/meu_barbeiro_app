import 'package:flutter/material.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Map<String, dynamic>> barbeariasVinculadas = [];

  final List<Map<String, dynamic>> barbeariasDaCidade = [
    {
      'nome': 'Barbearia Imperial',
      'nota': 4.8,
      'servicos': ['Corte', 'Barba', 'Sobrancelha'],
      'agendaCheia': false,
      'descricao': 'Especializada em cortes modernos e atendimento top!',
      'endereco': 'Rua do Corte, 100 - SP',
      'foto': null,
    },
    {
      'nome': 'Estilo Fino',
      'nota': 4.5,
      'servicos': ['Corte degradê', 'Hidratação'],
      'agendaCheia': true,
      'descricao': 'Barbearia boutique com foco em cuidados pessoais.',
      'endereco': 'Av. Finesse, 200 - SP',
      'foto': null,
    },
  ];

  void _adicionarBarbearia(Map<String, dynamic> barbearia) {
    setState(() {
      barbeariasVinculadas.add(barbearia);
    });
    Navigator.of(context).pop();
  }

  void _mostrarListaBarbearias() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return ListView.builder(
          itemCount: barbeariasDaCidade.length,
          itemBuilder: (context, index) {
            final b = barbeariasDaCidade[index];
            return ListTile(
              title:
                  Text(b['nome'], style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                b['servicos'].join(', '),
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: ElevatedButton(
                onPressed: () => _adicionarBarbearia(b),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFf39c12),
                ),
                child: const Text('Adicionar'),
              ),
            );
          },
        );
      },
    );
  }

  void _abrirFicha(Map<String, dynamic> barbearia) {
    Navigator.of(context).pushNamed(
      '/barbershop-details',
      arguments: barbearia,
    );
  }

  void _agendar(Map<String, dynamic> barbearia) {
    // TODO: abrir agendamento para essa barbearia
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Agendar em ${barbearia['nome']}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Minhas Barbearias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: barbeariasVinculadas.isEmpty
            ? Center(
                child: ElevatedButton.icon(
                  onPressed: _mostrarListaBarbearias,
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Barbearia'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFf39c12),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: barbeariasVinculadas.length,
                itemBuilder: (context, index) {
                  final b = barbeariasVinculadas[index];
                  return GestureDetector(
                    onTap: () => _abrirFicha(b),
                    child: Card(
                      color: const Color(0xFF2C2C2C),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(b['nome'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            const SizedBox(height: 4),
                            Text('Nota: ${b['nota']} ⭐',
                                style: const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 4),
                            Text(
                              b['agendaCheia']
                                  ? 'Agenda cheia'
                                  : 'Vagas disponíveis',
                              style: TextStyle(
                                color: b['agendaCheia']
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () => _agendar(b),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFf39c12),
                                ),
                                child: const Text('Agendar'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
