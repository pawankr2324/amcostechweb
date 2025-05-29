import 'package:amcostechweb/core/utils/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_cubit.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_state.dart';

/// Phone authentication screen, responsive via ResponsiveLayout.
class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    Widget content = BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthCodeSent) {
          Navigator.pushNamed(context, '/otp', arguments: state.verificationId);
        } else if (state is PhoneAuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixText: '+',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
            builder: (context, state) {
              if (state is PhoneAuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed:
                    () => context.read<PhoneAuthCubit>().verifyPhone(
                      phoneController.text.trim(),
                    ),
                child: const Text('Send OTP'),
              );
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: ResponsiveLayout(
        mobile: Padding(padding: const EdgeInsets.all(16), child: content),
        tablet: Center(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: content,
            ),
          ),
        ),
        desktop: Center(
          child: SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
