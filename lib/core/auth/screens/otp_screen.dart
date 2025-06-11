// lib/core/auth/otp_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication/authentication.dart';
import 'package:amcostechweb/core/auth/widgets/otp_card.dart';
import 'package:amcostechweb/core/utils/responsive/responsive_layout.dart';

/// OTP verification screen. Expects a [verificationId] from GoRouter’s queryParams.
/// Displays an OTPCaRd to enter SMS code and verify.
/// When verification succeeds, UserCubit emits UserLoaded and redirect → /home.
class OTPScreen extends StatelessWidget {
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    final smsController = TextEditingController();

    return ResponsiveLayout(
      // ▶ MOBILE layout
      mobile: Scaffold(
        body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthFailure) {
              // Show errors (e.g. invalid code, expired code, etc.)
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is PhoneAuthSuccess) {
              // On success, FirebaseAuth’s state changes → UserCubit emits UserLoaded,
              // and GoRouter’s redirect will send you to /home automatically.
            }
          },
          builder: (context, state) {
            return Center(
              child: OTPCard(
                smsController: smsController,
                verificationId: verificationId,
              ),
            );
          },
        ),
      ),

      // ▶ TABLET layout
      tablet: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
              listener: (context, state) {
                if (state is PhoneAuthFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return OTPCard(
                  smsController: smsController,
                  verificationId: verificationId,
                );
              },
            ),
          ),
        ),
      ),

      // ▶ DESKTOP layout
      desktop: Scaffold(
        body: Center(
          child: SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                listener: (context, state) {
                  if (state is PhoneAuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return OTPCard(
                    smsController: smsController,
                    verificationId: verificationId,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
