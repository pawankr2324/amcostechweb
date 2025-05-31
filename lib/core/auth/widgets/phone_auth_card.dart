// File: lib/core/presentation/widgets/phone_auth_card.dart

import 'package:amcostechweb/core/utils/constants/assets_image.dart';

import 'package:amcostechweb/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_cubit.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_state.dart';
// Adjust path if needed

/// A card‐styled widget for phone authentication (sending OTP).
/// Designed to look good on web by constraining width, adding padding,
/// and using a rounded, elevated Card.
class PhoneAuthCard extends StatelessWidget {
  final TextEditingController phoneController;

  const PhoneAuthCard({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    // Center the card on larger screens; card has a max width for readability
    return Center(
      child: Card(
        color: Colors.black.withAlpha(200),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        // Constrain the width so it doesn't stretch too wide on web
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsImage.amcosTechLogo,
                  height: 100,
                  color: Colors.blue,
                ),
                Text(
                  'Let\'s Begin',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Phone number field with "+91" prefix
                CustomTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  prefixText: '+91 ',
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 24),

                // BlocBuilder to show loading indicator or button
                BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
                  builder: (context, state) {
                    if (state is PhoneAuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      width: double.infinity,
                      // Use Elevated Button that expands to full card width
                      child: ElevatedButton(
                        onPressed: () {
                          final phoneNumber = phoneController.text.trim();
                          if (phoneNumber.isNotEmpty) {
                            context.read<PhoneAuthCubit>().verifyPhone(
                              '+91$phoneNumber',
                            );
                          } else {
                            // Optionally show a snackbar or error if empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter a valid phone number',
                                ),
                              ),
                            );
                          }
                        },

                        child: const Text('Send OTP'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
