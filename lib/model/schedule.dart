class Schedule {
  final String specialist;
  final String patient;
  final bool online;
  final DateTime from;
  final DateTime to;
  String? signs;
  String? id;
  List<String>? tests;

  Schedule({
    required this.specialist,
    required this.patient,
    required this.online,
    required this.from,
    required this.to,
    this.signs,
    this.tests,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'specialist': specialist,
      'patient': patient,
      'online': online,
      'from': from,
      'to': to,
      'tests': tests,
      'signs': signs,
    };
  }
}
