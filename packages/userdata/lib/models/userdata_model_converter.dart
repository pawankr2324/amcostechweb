// File: packages/userdata/lib/models/userdata_model_converter.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'userdata_model.dart';

/// Converts a Firestore document (snapshot) into a [UserdataModel].
UserdataModel userdataModelFromSnapshot(
  DocumentSnapshot<Map<String, dynamic>> snapshot,
) {
  final data = snapshot.data();
  if (data == null) {
    throw StateError('Missing data for userdata document ${snapshot.id}');
  }

  return UserdataModel(
    uid: snapshot.id,
    firstName: data['firstName'] as String,
    lastName: data['lastName'] as String,
    email: data['email'] as String,
    phoneNumber: data['phoneNumber'] as String,
    designation: data['designation'] as String,
    role: data['role'] as String,
    photoURL: data['photoURL'] as String?,
    createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    lastUpdated: (data['lastUpdated'] as Timestamp?)?.toDate(),
    bio: data['bio'] as String?,
    address:
        data['address'] != null
            ? Address(
              street: data['address']['street'] as String,
              city: data['address']['city'] as String,
              state: data['address']['state'] as String,
              country: data['address']['country'] as String,
            )
            : null,
    preferences:
        data['preferences'] != null
            ? Preferences(
              darkMode: data['preferences']['darkMode'] as bool,
              language: data['preferences']['language'] as String,
            )
            : null,
  );
}

/// Converts a [UserdataModel] into a Map suitable for Firestore.
Map<String, dynamic> userdataModelToDocument(UserdataModel userdata) {
  final map = <String, dynamic>{
    'firstName': userdata.firstName,
    'lastName': userdata.lastName,
    'email': userdata.email,
    'phoneNumber': userdata.phoneNumber,
    'designation': userdata.designation,
    'role': userdata.role,
    'createdAt':
        userdata.createdAt != null
            ? Timestamp.fromDate(userdata.createdAt!)
            : FieldValue.serverTimestamp(),
    'lastUpdated': Timestamp.fromDate(userdata.lastUpdated ?? DateTime.now()),
  };

  if (userdata.photoURL != null) {
    map['photoURL'] = userdata.photoURL;
  }
  if (userdata.bio != null) {
    map['bio'] = userdata.bio;
  }
  if (userdata.address != null) {
    map['address'] = {
      'street': userdata.address!.street,
      'city': userdata.address!.city,
      'state': userdata.address!.state,
      'country': userdata.address!.country,
    };
  }
  if (userdata.preferences != null) {
    map['preferences'] = {
      'darkMode': userdata.preferences!.darkMode,
      'language': userdata.preferences!.language,
    };
  }

  return map;
}
