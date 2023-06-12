class Request {
  final String specialist;
  final String patient;
  final bool online;
  final DateTime time;
  bool ok = false;
  bool pending = true;
  String? id;
  DateTime? adjusted;

  Request({
    required this.specialist,
    required this.patient,
    required this.online,
    required this.time,
    this.id,
    this.adjusted,
  });

  Map<String, dynamic> toMap() {
    return {
      'specialist': specialist,
      'patient': patient,
      'online': online,
      'at': time,
      'pending': pending,
      'ok': ok,
    };
  }
}
