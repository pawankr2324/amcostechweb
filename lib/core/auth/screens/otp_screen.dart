import 'package:amcostechweb/core/utils/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_cubit.dart';
import 'package:authentication/logic/auth_cubit/phone_auth_state.dart';

/// OTP verification screen, responsive via ResponsiveLayout.
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final smsController = TextEditingController();
    final verificationId = ModalRoute.of(context)!.settings.arguments as String;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: smsController,
          decoration: const InputDecoration(labelText: 'OTP'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
          builder: (context, state) {
            if (state is PhoneAuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ElevatedButton(
              onPressed:
                  () => context.read<PhoneAuthCubit>().submitOTP(
                    verificationId,
                    smsController.text.trim(),
                  ),
              child: const Text('Verify'),
            );
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Enter OTP')),
      body: ResponsiveLayout(
        mobile: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocListener<PhoneAuthCubit, PhoneAuthState>(
            listener: (context, state) {
              if (state is PhoneAuthSuccess) {
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is PhoneAuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: content,
          ),
        ),
        tablet: Center(
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: BlocListener<PhoneAuthCubit, PhoneAuthState>(
                listener: (context, state) {
                  if (state is PhoneAuthSuccess) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (state is PhoneAuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: content,
              ),
            ),
          ),
        ),
        desktop: Center(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: BlocListener<PhoneAuthCubit, PhoneAuthState>(
                listener: (context, state) {
                  if (state is PhoneAuthSuccess) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (state is PhoneAuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
