enum PlanType { lite, pro }

class PlanRules {
  final String nome;
  final double preco;
  final int agendamentosMensais;
  final int servicosCadastraveis;
  final int downloadsCsv;
  final int barbeirosPorBarbearia;
  final bool estatisticasDisponiveis;
  final bool agendamentoOnline;
  final List<String> canaisSuporte;

  const PlanRules({
    required this.nome,
    required this.preco,
    required this.agendamentosMensais,
    required this.servicosCadastraveis,
    required this.downloadsCsv,
    required this.barbeirosPorBarbearia,
    required this.estatisticasDisponiveis,
    required this.agendamentoOnline,
    required this.canaisSuporte,
  });

  static const Map<PlanType, PlanRules> planos = {
    // TODO futuramente trazer os planos via API
    PlanType.lite: PlanRules(
      nome: 'Barber Lite',
      preco: 19.90,
      agendamentosMensais: 30,
      servicosCadastraveis: 10,
      downloadsCsv: 1,
      barbeirosPorBarbearia: 1,
      estatisticasDisponiveis: false,
      agendamentoOnline: false,
      canaisSuporte: ['ticket'],
    ),
    PlanType.pro: PlanRules(
      nome: 'Barber Pro',
      preco: 49.90,
      agendamentosMensais: 90,
      servicosCadastraveis: 30,
      downloadsCsv: 3,
      barbeirosPorBarbearia: 3,
      estatisticasDisponiveis: true,
      agendamentoOnline: true,
      canaisSuporte: ['ticket', 'whatsapp'],
    ),
  };
}
