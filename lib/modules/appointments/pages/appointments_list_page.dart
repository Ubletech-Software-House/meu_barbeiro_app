import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppointmentsListPage extends StatefulWidget {
  const AppointmentsListPage({super.key});

  @override
  State<AppointmentsListPage> createState() => _AppointmentsListPageState();
}

class _AppointmentsListPageState extends State<AppointmentsListPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> allAppointments = [
    {
      'cliente': 'João Silva',
      'data': DateTime(2024, 5, 3, 10, 0),
      'servico': 'Corte de cabelo',
      'valor': 30.0
    },
    {
      'cliente': 'Maria Costa',
      'data': DateTime(2024, 5, 20, 14, 0),
      'servico': 'Barba',
      'valor': 25.0
    },
    {
      'cliente': 'Lucas Martins',
      'data': DateTime(2024, 4, 10, 16, 0),
      'servico': 'Sobrancelha',
      'valor': 15.0
    },
    {
      'cliente': 'Rita Lopes',
      'data': DateTime(2025, 1, 15, 9, 0),
      'servico': 'Luzes',
      'valor': 100.0
    },
  ];

  String _searchQuery = '';
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    if (_currentMonth.month == 12) {
      setState(() {
        _currentMonth = DateTime(_currentMonth.year + 1, 1);
      });
    } else {
      setState(() {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      });
    }
  }

  List<Map<String, dynamic>> get visibleAppointments {
    return allAppointments.where((a) {
      final data = a['data'] as DateTime;
      final queryMatch = a['cliente']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final sameMonth =
          data.month == _currentMonth.month && data.year == _currentMonth.year;
      return queryMatch && sameMonth;
    }).toList();
  }

  Future<void> _exportCsv() async {
    final rows = [
      ['Cliente', 'Data', 'Serviço', 'Valor']
    ];

    for (var a in visibleAppointments) {
      rows.add([
        a['cliente'],
        DateFormat('dd/MM/yyyy HH:mm').format(a['data']),
        a['servico'],
        a['valor'].toStringAsFixed(2),
      ]);
    }

    final csv = const ListToCsvConverter().convert(rows);
    final dir = await getApplicationDocumentsDirectory();
    final file = File(
        '${dir.path}/agendamentos_${_currentMonth.month}_${_currentMonth.year}.csv');
    await file.writeAsString(csv);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Arquivo exportado: ${file.path}')),
    );
  }

  void _criarAgendamento() {
    Navigator.of(context).pushNamed('/create-appointment');
  }

  bool _canNavigateToPreviousMonth() {
    final now = DateTime.now();
    return _currentMonth.isAfter(DateTime(now.year, 1));
  }

  bool _canNavigateToNextMonth() {
    final now = DateTime.now();
    return (_currentMonth.year == now.year && _currentMonth.month < 12) ||
        (_currentMonth.year == now.year + 1 && _currentMonth.month == 1);
  }

  @override
  Widget build(BuildContext context) {
    final String monthName =
        DateFormat('MMMM yyyy', 'pt_BR').format(_currentMonth);

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Meus Agendamentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _exportCsv,
            tooltip: 'Exportar CSV',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:
                      _canNavigateToPreviousMonth() ? _previousMonth : null,
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                ),
                Text(
                  monthName[0].toUpperCase() + monthName.substring(1),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  onPressed: _canNavigateToNextMonth() ? _nextMonth : null,
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Buscar por cliente',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white70),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: visibleAppointments.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum agendamento encontrado',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: visibleAppointments.length,
                      itemBuilder: (context, index) {
                        final a = visibleAppointments[index];
                        return Card(
                          color: const Color(0xFF2C2C2C),
                          child: ListTile(
                            title: Text(
                              '${a['cliente']} - ${a['servico']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy • HH:mm')
                                  .format(a['data']),
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Text(
                              'R\$ ${a['valor'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFFf39c12),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFf39c12),
        onPressed: _criarAgendamento,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Conversor simples de List<List<String>> para CSV
class ListToCsvConverter {
  const ListToCsvConverter();

  String convert(List<List<String>> rows) {
    return rows.map((r) => r.map((v) => '"$v"').join(',')).join('\n');
  }
}
