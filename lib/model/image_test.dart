class ImagingTest {
  final DateTime date;
  final String name;
  final DateTime dob;
  final int gender;
  final List<String> images;

  ImagingTest({
    required this.date,
    required this.name,
    required this.dob,
    required this.gender,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'name': name,
      'dob': dob,
      'gender': gender,
      'images': images,
    };
  }
}
