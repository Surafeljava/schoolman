import 'dart:convert';

class RegistrarModel {
  final String name;
  final String fatherName;
  final String gFatherName;
  final String bDate;
  final String phone;
  final String address;
  final String uid;
  final int userType;
  RegistrarModel({
    required this.name,
    required this.fatherName,
    required this.gFatherName,
    required this.bDate,
    required this.phone,
    required this.address,
    required this.uid,
    required this.userType,
  });

  RegistrarModel copyWith({
    String? name,
    String? fatherName,
    String? gFatherName,
    String? bDate,
    String? phone,
    String? address,
    String? uid,
    int? userType,
  }) {
    return RegistrarModel(
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      gFatherName: gFatherName ?? this.gFatherName,
      bDate: bDate ?? this.bDate,
      phone: phone ?? this.phone,
      address: address ?? this.address,
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
      'uid': uid,
      'userType': userType,
    };
  }

  factory RegistrarModel.fromMap(Map<String, dynamic> map) {
    return RegistrarModel(
      name: map['name'],
      fatherName: map['fatherName'],
      gFatherName: map['gFatherName'],
      bDate: map['bDate'],
      phone: map['phone'],
      address: map['address'],
      uid: map['uid'],
      userType: map['userType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrarModel.fromJson(String source) =>
      RegistrarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegistrarModel(name: $name, fatherName: $fatherName, gFatherName: $gFatherName, bDate: $bDate, phone: $phone, address: $address, uid: $uid, userType: $userType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegistrarModel &&
      other.name == name &&
      other.fatherName == fatherName &&
      other.gFatherName == gFatherName &&
      other.bDate == bDate &&
      other.phone == phone &&
      other.address == address &&
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
      uid.hashCode ^
      userType.hashCode;
  }
}
