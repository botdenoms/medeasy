class BloodTest {
  // patient details
  final DateTime date;
  final String name;
  final DateTime dob;
  final int gender;
  // complete blood count
  final double hermoglobin; //[v]g/dl 13.5 - 17.5
  final double wbc; // [v]x10^3/uL   4.5 - 11.0
  final int rbc; // [v]x10^6/uL   150 - 450
  final double platelets; // [v]x10^3/uL   4.5 - 11.0
  // lipid panel
  final int cholesterol; // [v] mg/dL <200  LDL<100  HDL>60
  final int triglycerides; // [v] mg/dL <150
  // blood glucose
  final double glucoseF; // [v] mg/dL 70 - 100 fasting
  final double glucoseP; // [v] mg/dL 70 - 140 postprandial

  BloodTest({
    required this.date,
    required this.name,
    required this.dob,
    required this.gender,
    required this.hermoglobin,
    required this.wbc,
    required this.rbc,
    required this.platelets,
    required this.cholesterol,
    required this.triglycerides,
    required this.glucoseF,
    required this.glucoseP,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'name': name,
      'dob': dob,
      'gender': gender,
      'hermoglobin': hermoglobin,
      'wbc': wbc,
      'rbc': rbc,
      'platelets': platelets,
      'cholesterol': cholesterol,
      'triglycerides': triglycerides,
      'glucoseF': glucoseF,
      'glucoseP': glucoseP,
    };
  }
}
