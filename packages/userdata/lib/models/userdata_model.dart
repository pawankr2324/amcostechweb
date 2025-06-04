// File: packages/userdata/lib/models/userdata_model.dart

import 'package:equatable/equatable.dart';

class UserdataModel extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String designation;
  final String role;
  final String? photoURL;
  final DateTime? createdAt;
  final DateTime? lastUpdated;
  final String? bio;
  final Address? address;
  final Preferences? preferences;

  const UserdataModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.designation,
    required this.role,
    this.photoURL,
    this.createdAt,
    this.lastUpdated,
    this.bio,
    this.address,
    this.preferences,
  });

  @override
  List<Object?> get props => [
    uid,
    firstName,
    lastName,
    email,
    phoneNumber,
    designation,
    role,
    photoURL,
    createdAt,
    lastUpdated,
    bio,
    address,
    preferences,
  ];

  UserdataModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? designation,
    String? role,
    String? photoURL,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? bio,
    Address? address,
    Preferences? preferences,
  }) {
    return UserdataModel(
      uid: uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      designation: designation ?? this.designation,
      role: role ?? this.role,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      preferences: preferences ?? this.preferences,
    );
  }
}

class Address extends Equatable {
  final String street;
  final String city;
  final String state;
  final String country;

  const Address({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
  });

  @override
  List<Object?> get props => [street, city, state, country];
}

class Preferences extends Equatable {
  final bool darkMode;
  final String language;

  const Preferences({required this.darkMode, required this.language});

  @override
  List<Object?> get props => [darkMode, language];
}
