class ImagingTest {
  final List<String> images;

  ImagingTest({required this.images});

  Map<String, dynamic> toMap() {
    return {
      'images': images,
    };
  }
}
