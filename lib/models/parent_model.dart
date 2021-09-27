import 'dart:convert';

class ParentModel {
  final String name;
  final String fatherName;
  final String gFatherName;
  final String bDate;
  final String phone;
  final String address;
  final String studentId;
  final String uid;
  final int userType;
  ParentModel({
    required this.name,
    required this.fatherName,
    required this.gFatherName,
    required this.bDate,
    required this.phone,
    required this.address,
    required this.studentId,
    required this.uid,
    required this.userType,
  });

  ParentModel copyWith({
    String? name,
    String? fatherName,
    String? gFatherName,
    String? bDate,
    String? phone,
    String? address,
    String? studentId,
    String? uid,
    int? userType,
  }) {
    return ParentModel(
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      gFatherName: gFatherName ?? this.gFatherName,
      bDate: bDate ?? this.bDate,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      studentId: studentId ?? this.studentId,
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
      'studentId': studentId,
      'uid': uid,
      'userType': userType,
    };
  }

  factory ParentModel.fromMap(Map<String, dynamic> map) {
    return ParentModel(
      name: map['name'],
      fatherName: map['fatherName'],
      gFatherName: map['gFatherName'],
      bDate: map['bDate'],
      phone: map['phone'],
      address: map['address'],
      studentId: map['studentId'],
      uid: map['uid'],
      userType: map['userType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParentModel.fromJson(String source) =>
      ParentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParentModel(name: $name, fatherName: $fatherName, gFatherName: $gFatherName, bDate: $bDate, phone: $phone, address: $address, studentId: $studentId, uid: $uid, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ParentModel &&
      other.name == name &&
      other.fatherName == fatherName &&
      other.gFatherName == gFatherName &&
      other.bDate == bDate &&
      other.phone == phone &&
      other.address == address &&
      other.studentId == studentId &&
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
      studentId.hashCode ^
      uid.hashCode ^
      userType.hashCode;
  }
}
