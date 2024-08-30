import 'package:app_for_testing/bloc/login/login_bloc.dart';
import 'package:app_for_testing/bloc/login/login_event.dart';
import 'package:app_for_testing/bloc/login/login_state.dart';
import 'package:app_for_testing/components/my_button.dart';
import 'package:app_for_testing/components/my_form.dart';
import 'package:app_for_testing/screens/wrapper.dart';
import 'package:app_for_testing/services/auth_services.dart';
import 'package:app_for_testing/services/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  final String? role;

  const LoginPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccess && !state.isSubmitting) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Wrapper(role: role!)));
              } else if (state.hasFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureMessage!)));
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Image.asset(
                    'assets/images/login_bg.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFFFCFCFC),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 100,
                    right: 100,
                    child: Image.asset(
                      'assets/images/upang_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 50, left: 24, right: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 48),
                        Text(
                          role!,
                          style: GoogleFonts.nunito(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Please sign in to your account',
                            style: GoogleFonts.nunito(
                                fontSize: 14, color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                        const SizedBox(height: 24),
                        MyForm(
                            labelText: 'Email',
                            errorText: !state.isEmailNotEmpty
                                ? 'Enter email'
                                : (!state.isEmailValid
                                    ? 'Invalid email'
                                    : null),
                            icon: const Icon(Icons.person),
                            onChanged: (value) => context
                                .read<LoginBloc>()
                                .add(LoginEmailChanged(email: value))),
                        const SizedBox(height: 16),
                        MyForm(
                            labelText: 'Password',
                            errorText: !state.isPasswordNotEmpty
                                ? 'Enter password'
                                : (!state.isPasswordValid
                                    ? 'Password should be greater than 6'
                                    : null),
                            icon: const Icon(Icons.lock),
                            obscureText: true,
                            onChanged: (value) => context
                                .read<LoginBloc>()
                                .add(LoginPassChanged(password: value))),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.nunito(
                                  fontSize: 14, color: const Color(0xFF3B3B3B)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        MyButton(
                            onTap: state.isFormValid
                                ? () => context
                                    .read<LoginBloc>()
                                    .add(LoginSubmitted(role: role!))
                                : null,
                            buttonText: 'Login')
                      ],
                    ),
                  ),
                  if (state.isSubmitting) ...[
                    const Center(child: CircularProgressIndicator()),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      ),
                    )
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
