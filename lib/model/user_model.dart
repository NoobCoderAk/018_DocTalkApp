// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final String id;
  final String name;
  final String nickname;
  final String email;
  final String description;
  final String address;
  final String specialist;
  final String license;
  UserInfo({
    required this.id,
    required this.name,
    required this.nickname,
    required this.email,
    required this.description,
    required this.address,
    required this.specialist,
    required this.license,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'nickname': nickname,
      'email': email,
      'description': description,
      'address': address,
      'specialist': specialist,
      'license': license,
    };
  }

  factory UserInfo.fromDocumnet(DocumentSnapshot doc) {
    return UserInfo(
      id: doc['id'] as String,
      name: doc['name'] as String,
      nickname: doc['nickname'] as String,
      email: doc['email'] as String,
      description: doc['description'] as String,
      address: doc['address'] as String,
      specialist: doc['specialist'] as String,
      license: doc['license'] as String,
    );
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] as String,
      name: map['name'] as String,
      nickname: map['nickname'] as String,
      email: map['email'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      specialist: map['specialist'] as String,
      license: map['license'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  UserInfo copyWith({
    String? id,
    String? name,
    String? nickname,
    String? email,
    String? description,
    String? address,
    String? specialist,
    String? license,
  }) {
    return UserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      description: description ?? this.description,
      address: address ?? this.address,
      specialist: specialist ?? this.specialist,
      license: license ?? this.license,
    );
  }

  @override
  String toString() {
    return 'UserInfo(id: $id, name: $name, nickname: $nickname, email: $email, description: $description, address: $address, specialist: $specialist, license: $license)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.nickname == nickname &&
        other.email == email &&
        other.description == description &&
        other.address == address &&
        other.specialist == specialist &&
        other.license == license;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        nickname.hashCode ^
        email.hashCode ^
        description.hashCode ^
        address.hashCode ^
        specialist.hashCode ^
        license.hashCode;
  }
}
