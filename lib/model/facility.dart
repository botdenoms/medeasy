class Facility {
  final String name;
  final List<String> location;
  final String email;
  final String pobox;
  final String lincence;
  final String lincenceImg;
  final String id;
  List<String> test = [];

  Facility({
    required this.name,
    required this.location,
    required this.email,
    required this.pobox,
    required this.lincence,
    required this.lincenceImg,
    required this.id,
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
    };
  }
}
