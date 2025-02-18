// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SkillModel {
  final String nameSkill;
  final String uidRecord;
  final Timestamp timestamp;
  SkillModel({
    required this.nameSkill,
    required this.uidRecord,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameSkill': nameSkill,
      'uidRecord': uidRecord,
      'timestamp': timestamp,
    };
  }

  factory SkillModel.fromMap(Map<String, dynamic> map) {
    return SkillModel(
      nameSkill: (map['nameSkill'] ?? '') as String,
      uidRecord: (map['uidRecord'] ?? '') as String,
      timestamp: (map['timestamp'] ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SkillModel.fromJson(String source) => SkillModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
