import 'dart:convert';

class StudentModel {
  final String name;
  final String fatherName;
  final String gFatherName;
  final String bDate;
  final String phone;
  final String address;
  final String classValue;
  final String uid;
  final int userType;
  StudentModel({
    required this.name,
    required this.fatherName,
    required this.gFatherName,
    required this.bDate,
    required this.phone,
    required this.address,
    required this.classValue,
    required this.uid,
    required this.userType,
  });

  StudentModel copyWith({
    String? name,
    String? fatherName,
    String? gFatherName,
    String? bDate,
    String? phone,
    String? address,
    String? classValue,
    String? uid,
    int? userType,
  }) {
    return StudentModel(
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      gFatherName: gFatherName ?? this.gFatherName,
      bDate: bDate ?? this.bDate,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      classValue: classValue ?? this.classValue,
      uid: uid ?? this.uid,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fatherName': fatherName,
      'gFatherName': gFatherName,
      'bDate': bDate,
      'phone': phone,
      'address': address,
      'classValue': classValue,
      'uid': uid,
      'userType': userType,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      name: map['name'],
      fatherName: map['fatherName'],
      gFatherName: map['gFatherName'],
      bDate: map['bDate'],
      phone: map['phone'],
      address: map['address'],
      classValue: map['classValue'],
      uid: map['uid'],
      userType: map['userType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentModel(name: $name, fatherName: $fatherName, gFatherName: $gFatherName, bDate: $bDate, phone: $phone, address: $address, classValue: $classValue, uid: $uid, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StudentModel &&
      other.name == name &&
      other.fatherName == fatherName &&
      other.gFatherName == gFatherName &&
      other.bDate == bDate &&
      other.phone == phone &&
      other.address == address &&
      other.classValue == classValue &&
      other.uid == uid &&
      other.userType == userType;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      fatherName.hashCode ^
      gFatherName.hashCode ^
      bDate.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      classValue.hashCode ^
      uid.hashCode ^
      userType.hashCode;
  }
}
