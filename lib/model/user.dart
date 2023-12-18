class User {
  final String name;
  final String telephone;
  final String email;
  bool? specialist = false;
  bool? facility = false;
  DateTime? at;

  User({
    required this.name,
    required this.telephone,
    required this.email,
    this.at,
    this.specialist,
    this.facility,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'telephone': telephone,
      'email': email,
      'specialist': specialist,
      'at': at,
      'facility': facility,
    };
  }
}
