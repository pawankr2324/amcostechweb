// File: packages/userdata/lib/src/local/local_user_data_source.dart

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:userdata/models/userdata_model.dart';

/// A JSON‐based cache layer for UserdataModel, storing everything under one key.
class LocalUserDataSource {
  static const _cacheKey = 'cached_user';

  /// Save the entire [UserdataModel] as JSON.
  Future<void> cacheUserData(UserdataModel u) async {
    final prefs = await SharedPreferences.getInstance();

    // Build a pure‐Dart map, matching your constructor exactly:
    final jsonMap = <String, dynamic>{
      'uid': u.uid,
      'firstName': u.firstName,
      'lastName': u.lastName,
      'email': u.email,
      'phoneNumber': u.phoneNumber,
      'designation': u.designation,
      'role': u.role,
      if (u.photoURL != null) 'photoURL': u.photoURL,
      if (u.createdAt != null) 'createdAt': u.createdAt!.toIso8601String(),
      if (u.lastUpdated != null)
        'lastUpdated': u.lastUpdated!.toIso8601String(),
      if (u.bio != null) 'bio': u.bio,
      'address':
          u.address != null
              ? {
                'street': u.address!.street,
                'city': u.address!.city,
                'state': u.address!.state,
                'country': u.address!.country,
              }
              : null,
      'preferences':
          u.preferences != null
              ? {
                'darkMode': u.preferences!.darkMode,
                'language': u.preferences!.language,
              }
              : null,
    };

    await prefs.setString(_cacheKey, jsonEncode(jsonMap));
  }

  /// Read back the JSON and rebuild your model (and nested types) inline.
  Future<UserdataModel?> getCachedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cacheKey);
    if (jsonString == null) return null;

    final map = jsonDecode(jsonString) as Map<String, dynamic>;

    // Inline Address reconstruction
    final addrMap = map['address'] as Map<String, dynamic>?;
    final address =
        addrMap != null
            ? Address(
              street: addrMap['street'] as String,
              city: addrMap['city'] as String,
              state: addrMap['state'] as String,
              country: addrMap['country'] as String,
            )
            : null;

    // Inline Preferences reconstruction
    final prefMap = map['preferences'] as Map<String, dynamic>?;
    final preferences =
        prefMap != null
            ? Preferences(
              darkMode: prefMap['darkMode'] as bool,
              language: prefMap['language'] as String,
            )
            : null;

    return UserdataModel(
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      designation: map['designation'] as String,
      role: map['role'] as String,
      photoURL: map['photoURL'] as String?,
      createdAt:
          map['createdAt'] != null
              ? DateTime.parse(map['createdAt'] as String)
              : null,
      lastUpdated:
          map['lastUpdated'] != null
              ? DateTime.parse(map['lastUpdated'] as String)
              : null,
      bio: map['bio'] as String?,
      address: address,
      preferences: preferences,
    );
  }

  /// Clears the cached JSON.
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
