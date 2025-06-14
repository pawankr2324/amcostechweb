import 'package:amcostechweb/core/utils/constants/assets_image.dart';
import 'package:amcostechweb/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/authentication.dart';

/// A card‐styled widget for OTP verification (entering OTP and submitting).
/// Similar styling to PhoneAuthCard, with a fixed max width, padding,
/// and rounded corners for a clean web‐friendly UI.
class OTPCard extends StatelessWidget {
  final TextEditingController smsController;
  final String verificationId;

  const OTPCard({
    super.key,
    required this.smsController,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black.withAlpha(200),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  'Verify OTP',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // OTP input field
                CustomTextField(
                  controller: smsController,
                  label: 'OTP',
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 24),

                // BlocBuilder to show loading indicator or the Verify button
                BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
                  builder: (context, state) {
                    if (state is PhoneAuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final otp = smsController.text.trim();
                          if (otp.isNotEmpty) {
                            context.read<PhoneAuthCubit>().submitOTP(
                              verificationId,
                              otp,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter the OTP'),
                              ),
                            );
                          }
                        },

                        child: const Text('Verify'),
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
