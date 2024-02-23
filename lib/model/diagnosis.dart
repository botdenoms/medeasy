class Diagnosis {
  final String findings;
  final String recommends;
  final List<String> prescripts;
  final String specialist;
  final String patient;
  final String schedule;
  final DateTime date;

  Diagnosis({
    required this.findings,
    required this.recommends,
    required this.prescripts,
    required this.specialist,
    required this.patient,
    required this.schedule,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'findings': findings,
      'recommends': recommends,
      'prescripts': prescripts,
      'specialist': specialist,
      'patient': patient,
      'schedule': schedule,
      'date': date,
    };
  }
}
