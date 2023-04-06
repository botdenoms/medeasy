import 'package:medeasy/model/models.dart';

class Request {
  final Specialist specialist;
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
      'specialist': specialist.id,
      'user': patient,
      'online': online,
      'at': time,
      'pending': pending,
      'ok': ok,
    };
  }
}
