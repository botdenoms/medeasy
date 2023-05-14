class Request {
  final String specialist;
  final String patient;
  final bool online;
  final DateTime time;
  bool ok = false;
  bool pending = true;

  Request({
    required this.specialist,
    required this.patient,
    required this.online,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'specialist': specialist,
      'user': patient,
      'online': online,
      'at': time,
      'pending': pending,
      'ok': ok,
    };
  }
}
