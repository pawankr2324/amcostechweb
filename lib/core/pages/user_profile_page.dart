// File: lib/core/presentation/pages/user_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:userdata/logic/userdata_cubit.dart';
import 'package:userdata/models/userdata_model.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _designationController;
  late TextEditingController _roleController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _designationController = TextEditingController();
    _roleController = TextEditingController();

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      context.read<UserdataCubit>().subscribeToUserdata(currentUser.uid);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _designationController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _saveProfile(UserdataModel existingData) {
    if (_formKey.currentState!.validate()) {
      final updated = UserdataModel(
        uid: existingData.uid,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: existingData.email,
        phoneNumber: _phoneController.text.trim(),
        designation: _designationController.text.trim(),
        role: _roleController.text.trim(),
        photoURL: existingData.photoURL,
        createdAt: existingData.createdAt,
        lastUpdated: DateTime.now(),
        bio: existingData.bio,
        address: existingData.address,
        preferences: existingData.preferences,
      );
      context.read<UserdataCubit>().updateUserdata(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: BlocBuilder<UserdataCubit, UserdataState>(
        builder: (context, state) {
          if (state is UserdataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserdataLoaded) {
            final data = state.userdata;
            // Pre-fill controllers
            _firstNameController.text = data.firstName;
            _lastNameController.text = data.lastName;
            _phoneController.text = data.phoneNumber;
            _designationController.text = data.designation;
            _roleController.text = data.role;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            data.photoURL != null
                                ? NetworkImage(data.photoURL!)
                                : null,
                        child:
                            data.photoURL == null
                                ? const Icon(Icons.person, size: 50)
                                : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Required'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Required'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: data.email,
                      decoration: const InputDecoration(labelText: 'Email'),
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Required'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _designationController,
                      decoration: const InputDecoration(
                        labelText: 'Designation',
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Required'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _roleController,
                      decoration: const InputDecoration(labelText: 'Role'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Required'
                                  : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _saveProfile(data),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is UserdataError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No userdata available.'));
          }
        },
      ),
    );
  }
}
