import 'package:google_maps_flutter/google_maps_flutter.dart';

class Facility {
  final String name;
  final List<String> location;
  final String email;
  final String pobox;
  final String lincence;
  final String lincenceImg;
  final String id;
  List<String>? test = [];
  bool verified = false;
  DateTime? at;
  LatLng? geo;

  Facility({
    required this.name,
    required this.location,
    required this.email,
    required this.pobox,
    required this.lincence,
    required this.lincenceImg,
    required this.id,
    this.test,
    this.verified = false,
    this.at,
    this.geo,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'img': lincenceImg,
      'lincence': lincence,
      'pobox': pobox,
      'email': email,
      'id': id,
      'tests': test,
    };
  }
}
