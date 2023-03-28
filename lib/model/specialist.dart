class Specialist {
  final String speciality;
  final String location;
  final String profile;
  final String regNo;
  final String cert;
  final String name;
  final String id;
  bool verified = false;

  Specialist({
    required this.speciality,
    required this.location,
    required this.profile,
    required this.regNo,
    required this.cert,
    required this.name,
    required this.id,
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
