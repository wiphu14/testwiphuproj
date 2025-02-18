import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String uid;
  final String displayName;
  final String phoneNumber;
  final bool? user;
  final String? slogan;
  final String? description;
  final String? urlImage;
  final Timestamp? birthTimestamp;
  final num score;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    this.user,
    this.slogan,
    this.description,
    this.urlImage,
    this.birthTimestamp,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'user': user,
      'slogan': slogan,
      'description': description,
      'urlImage': urlImage,
      'birthTimestamp': birthTimestamp,
      'score': score,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: (map['uid'] ?? '') as String,
      displayName: (map['displayName'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
      user: (map['user'] ?? true) as bool,
      slogan: (map['slogan'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      urlImage: (map['urlImage'] ?? '') as String,
      birthTimestamp: map['birthTimestamp'],
      score: (map['score'] ?? 0) as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
