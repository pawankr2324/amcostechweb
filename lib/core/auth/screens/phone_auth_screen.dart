// lib/core/auth/phone_auth_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:amcostechweb/core/auth/widgets/phone_auth_card.dart';
import 'package:amcostechweb/core/utils/responsive/responsive_layout.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_cubit.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_state.dart';
import 'package:amcostechweb/core/router/app_router.dart';

/// Phone authentication screen, responsive via ResponsiveLayout.
/// Shows a PhoneAuthCard (which contains a TextField and “Send OTP” button).
/// Listens to PhoneAuthCubit: when code is sent, navigates to /otp?verificationId=…
class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    // A BlocListener that reacts to PhoneAuthState changes (e.g., code sent).
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthCodeSent) {
          // When Firebase successfully sends the OTP, navigate to /otp
          // passing the verificationId as a query parameter.
          context.go('${AppRoutes.otp}?verificationId=${state.verificationId}');
        } else if (state is PhoneAuthFailure) {
          // Show any error as a SnackBar
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: ResponsiveLayout(
        // ▶ MOBILE layout
        mobile: Scaffold(
          appBar: AppBar(title: const Text('Phone Authentication')),
          body: Center(child: PhoneAuthCard(phoneController: phoneController)),
        ),

        // ▶ DESKTOP layout: constrain width to 600px
        desktop: Scaffold(
          appBar: AppBar(title: const Text('Phone Authentication')),
          body: Center(
            child: SizedBox(
              width: 600,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: PhoneAuthCard(phoneController: phoneController),
              ),
            ),
          ),
        ),

        // ▶ TABLET layout: center in a 400px‐wide box
        tablet: Scaffold(
          appBar: AppBar(title: const Text('Phone Authentication')),
          body: Center(
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PhoneAuthCard(phoneController: phoneController),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
