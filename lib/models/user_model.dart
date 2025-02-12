import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  
  final String uid;
  final String displayName;
 final String phoneNumber;
 final bool? user;
 final String? slogan;
 final String? description;
 final String? urlImage;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    this.user,
    this.slogan,
    this.description,
    this.urlImage,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
