import 'dart:convert';

class GradeModel {
  final double grade;
  final String subject;
  GradeModel({
    required this.grade,
    required this.subject,
  });

  GradeModel copyWith({
    double? grade,
    String? subject,
  }) {
    return GradeModel(
      grade: grade ?? this.grade,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'grade': grade,
      'subject': subject,
    };
  }

  factory GradeModel.fromMap(Map<String, dynamic> map) {
    return GradeModel(
      grade: map['grade'],
      subject: map['subject'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GradeModel.fromJson(String source) => GradeModel.fromMap(json.decode(source));

  @override
  String toString() => 'GradeModel(grade: $grade, subject: $subject)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GradeModel &&
      other.grade == grade &&
      other.subject == subject;
  }

  @override
  int get hashCode => grade.hashCode ^ subject.hashCode;
}
