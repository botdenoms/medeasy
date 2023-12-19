class Test {
  final String client;
  final String facility;
  final DateTime date;
  final int type;
  String ref = '';

  Test({
    required this.client,
    required this.facility,
    required this.date,
    required this.type,
    required this.ref,
  });

  Map<String, dynamic> toMap() {
    return {
      'client': client,
      'facility': facility,
      'date': date,
      'type': type,
      'ref': ref,
    };
  }
}
