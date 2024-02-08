import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  UserModel copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid']?.toString() ?? '',
      displayName: map['displayName']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      photoUrl: map['photoUrl']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(uid: $uid, displayName: $displayName, email: $email, photoUrl: $photoUrl)';
  }

  @override
  List<Object> get props => [uid, displayName, email, photoUrl];
}
