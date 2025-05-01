import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClientCreateAppointmentPage extends StatefulWidget {
  const ClientCreateAppointmentPage({super.key});

  @override
  State<ClientCreateAppointmentPage> createState() =>
      _ClientCreateAppointmentPageState();
}

class _ClientCreateAppointmentPageState
    extends State<ClientCreateAppointmentPage> {
  DateTime? selectedDate;
  String? selectedService;
  String? selectedTime;

  List<String> horariosMock = [
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  @override
  Widget build(BuildContext context) {
    final barbearia =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final List<String> servicos = List<String>.from(barbearia['servicos']);

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: Text('Agendar - ${barbearia['nome']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text('Serviço:', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedService,
              items: servicos
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedService = value);
              },
              dropdownColor: const Color(0xFF2C2C2C),
              decoration: const InputDecoration(
                hintText: 'Selecione o serviço',
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text('Data:', style: TextStyle(color: Colors.white70)),
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
            const Text('Horário:', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: horariosMock.map((hora) {
                final isSelected = selectedTime == hora;
                return ChoiceChip(
                  label: Text(hora,
                      style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white)),
                  selected: isSelected,
                  selectedColor: const Color(0xFFf39c12),
                  backgroundColor: const Color(0xFF2C2C2C),
                  onSelected: (_) => setState(() => selectedTime = hora),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (selectedService == null ||
                    selectedDate == null ||
                    selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos')),
                  );
                  return;
                }

                // TODO: Enviar dados do agendamento à API
                // print('Cliente agendou em ${barbearia['nome']}');
                // print('Serviço: $selectedService');
                // print(
                //     'Data: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}');
                // print('Hora: $selectedTime');

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Agendamento realizado!')),
                );

                Navigator.of(context).pop(); // Volta para a tela anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39c12),
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Confirmar Agendamento'),
            )
          ],
        ),
      ),
    );
  }
}
