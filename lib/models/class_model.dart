import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClassModel {
  final String className;
  final List<String> subjects;
  ClassModel({
    required this.className,
    required this.subjects,
  });
  

  ClassModel copyWith({
    String? className,
    List<String>? subjects,
  }) {
    return ClassModel(
      className: className ?? this.className,
      subjects: subjects ?? this.subjects,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'className': className,
      'subjects': subjects,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      className: map['className'],
      subjects: List<String>.from(map['subjects']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) => ClassModel.fromMap(json.decode(source));

  @override
  String toString() => 'ClassModel(className: $className, subjects: $subjects)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ClassModel &&
      other.className == className &&
      listEquals(other.subjects, subjects);
  }

  @override
  int get hashCode => className.hashCode ^ subjects.hashCode;
}
