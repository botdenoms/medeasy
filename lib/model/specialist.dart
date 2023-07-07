import 'package:google_maps_flutter/google_maps_flutter.dart';

class Specialist {
  final String speciality;
  final List<String> location;
  final String profile;
  final String regNo;
  final String cert;
  final String name;
  final String id;
  bool verified = false;
  DateTime? at;
  LatLng? geo;

  Specialist({
    required this.speciality,
    required this.location,
    required this.profile,
    required this.regNo,
    required this.cert,
    required this.name,
    required this.id,
    this.verified = false,
    this.at,
    this.geo,
  });

  Map<String, dynamic> toMap() {
    return {
      'speciality': speciality,
      'location': location,
      'profile': profile,
      'regNo': regNo,
      'cert': cert,
      'name': name,
      'id': id,
    };
  }
}
