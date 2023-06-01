class Schedule {
  final String specialist;
  final String patient;
  final bool online;
  final DateTime time;
  String? id;

  Schedule({
    required this.specialist,
    required this.patient,
    required this.online,
    required this.time,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'specialist': specialist,
      'patient': patient,
      'online': online,
      'at': time,
    };
  }
}
