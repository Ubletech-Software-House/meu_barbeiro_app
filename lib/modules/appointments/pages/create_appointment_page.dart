import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({super.key});

  @override
  State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  Map<String, dynamic>? selectedService;
  DateTime? selectedDate;
  String? selectedTime;

  final int intervaloMinutos = 10; // intervalo configurável futuramente

  // Mock de horários ocupados no dia selecionado
  final List<String> horariosOcupados = [
    '09:00',
    '10:30',
    '13:00',
  ];

  // Gera os horários disponíveis com base na duração do serviço
  List<String> gerarHorariosDisponiveis() {
    if (selectedService == null || selectedDate == null) return [];

    final List<String> horarios = [];
    final inicio =
        DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, 8);
    final fim = DateTime(
        selectedDate!.year, selectedDate!.month, selectedDate!.day, 18);
    final duracao = selectedService!['duracao'] as int;

    DateTime atual = inicio;

    while (atual.add(Duration(minutes: duracao)).isBefore(fim)) {
      final horaFormatada = DateFormat.Hm().format(atual);
      final horaFim =
          DateFormat.Hm().format(atual.add(Duration(minutes: duracao)));

      final conflito = horariosOcupados.any((ocupado) {
        final h = TimeOfDay(
          hour: int.parse(ocupado.split(':')[0]),
          minute: int.parse(ocupado.split(':')[1]),
        );
        return atual.isBefore(DateTime(selectedDate!.year, selectedDate!.month,
                    selectedDate!.day, h.hour, h.minute)
                .add(Duration(minutes: duracao))) &&
            atual.add(Duration(minutes: duracao)).isAfter(DateTime(
                selectedDate!.year,
                selectedDate!.month,
                selectedDate!.day,
                h.hour,
                h.minute));
      });

      if (!conflito) {
        horarios.add('$horaFormatada - $horaFim');
      }

      atual = atual.add(Duration(minutes: intervaloMinutos));
    }

    return horarios;
  }

  Future<void> _selecionarServico() async {
    final selected = await Navigator.of(context).pushNamed('/select-service');

    if (selected != null && selected is Map<String, dynamic>) {
      setState(() {
        selectedService = selected;
        selectedTime = null; // reset ao trocar de serviço
      });
    }
  }

  void _confirmarAgendamento() {
    if (selectedService == null ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    // TODO: Enviar agendamento para API
    // print('Agendamento confirmado:');
    // print('Serviço: ${selectedService!['nome']}');
    // print('Data: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}');
    // print('Horário: $selectedTime');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agendamento realizado com sucesso!')),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final horariosDisponiveis = gerarHorariosDisponiveis();

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Novo Agendamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _selecionarServico,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
              ),
              icon: const Icon(Icons.search),
              label: const Text('Selecionar Serviço'),
            ),
            if (selectedService != null) ...[
              const SizedBox(height: 16),
              Text(
                'Selecionado: ${selectedService!['nome']} (${selectedService!['duracao']} min)',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
            const SizedBox(height: 24),
            const Text('Escolher data:', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  final isSelected = selectedDate != null &&
                      date.day == selectedDate!.day &&
                      date.month == selectedDate!.month;

                  return GestureDetector(
                    onTap: () => setState(() => selectedDate = date),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFf39c12)
                            : const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        DateFormat('dd/MM').format(date),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text('Horários disponíveis:',
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            if (horariosDisponiveis.isEmpty)
              const Text('Nenhum horário disponível',
                  style: TextStyle(color: Colors.white70)),
            if (horariosDisponiveis.isNotEmpty)
              Wrap(
                spacing: 8,
                children: horariosDisponiveis.map((h) {
                  final selected = h == selectedTime;
                  return ChoiceChip(
                    label: Text(h,
                        style: TextStyle(
                            color: selected ? Colors.black : Colors.white)),
                    selected: selected,
                    selectedColor: const Color(0xFFf39c12),
                    backgroundColor: const Color(0xFF2C2C2C),
                    onSelected: (_) => setState(() => selectedTime = h),
                  );
                }).toList(),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _confirmarAgendamento,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Confirmar Agendamento'),
            ),
          ],
        ),
      ),
    );
  }
}
