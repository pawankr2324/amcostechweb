import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticate/authenticate.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _captchaController = TextEditingController();
  String? _verificationId;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(FirebaseAuthRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Auth')),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpSent) {
              setState(() => _verificationId = state.verificationId);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Welcome ${state.user?.uid}')),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Phone Authentication'),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                ),
                if (_verificationId != null)
                  TextField(
                    controller: _otpController,
                    decoration: const InputDecoration(labelText: 'OTP'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    final bloc = context.read<AuthBloc>();
                    if (_verificationId == null) {
                      bloc.add(SendPhoneCode(_phoneController.text));
                    } else {
                      bloc.add(VerifySmsCode(
                        verificationId: _verificationId!,
                        smsCode: _otpController.text,
                      ));
                    }
                  },
                  child: Text(_verificationId == null ? 'Send Code' : 'Verify'),
                ),
                const Divider(),
                const Text('Email/Password Authentication'),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: _captchaController,
                  decoration: const InputDecoration(labelText: 'Captcha'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          SignInWithEmail(
                            email: _emailController.text,
                            password: _passwordController.text,
                            captchaToken: _captchaController.text,
                          ),
                        );
                  },
                  child: const Text('Sign In'),
                ),
                const Divider(),
                const Text('Google Authentication'),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignInWithGoogle());
                  },
                  child: const Text('Sign In with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
