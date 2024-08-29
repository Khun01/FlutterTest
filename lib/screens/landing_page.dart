import 'package:app_for_testing/bloc/login/login_bloc.dart';
import 'package:app_for_testing/bloc/login/login_event.dart';
import 'package:app_for_testing/bloc/login/login_state.dart';
import 'package:app_for_testing/components/my_button.dart';
import 'package:app_for_testing/screens/login_page.dart';
import 'package:app_for_testing/screens/wrapper.dart';
import 'package:app_for_testing/services/auth_services.dart';
import 'package:app_for_testing/services/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedRole;

    return BlocProvider(
      create: (context) =>
          LoginBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccess && !state.isSubmitting) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Wrapper(role: selectedRole!)));
              }else if (state.hasFailed && !state.isSubmitting) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(role: selectedRole!)));
              }
            },
            builder: (context, state) {
              return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0x33A3D9A5),
                  child: Stack(children: [
                    Positioned(
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/background.png',
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 50, left: 16, right: 16, bottom: 16),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/upang_logo.png',
                                width: 200,
                                height: 200,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'University\nof\nPangasinan',
                                style: GoogleFonts.abhayaLibre(
                                    fontSize: 30,
                                    color: const Color(0xFF3B3B3B)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Welcome to Help, isKo',
                                  style: GoogleFonts.nunito(
                                      fontSize: 32.7,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Text(
                                  'Track duties, grab opportunities, and stay organized. Simplify your journey with the Help, isKo App. Join the Help, isKo App today!',
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: const Color(0xCC3B3B3B)),
                                ),
                              ),
                              const SizedBox(height: 30),
                              MyButton(
                                onTap: () {
                                  selectedRole = 'Professor';
                                  context.read<LoginBloc>().add(
                                      CheckLoginStatusEvent(
                                          role: selectedRole!));
                                },
                                buttonText: 'Professor',
                                color: const Color(0xFF6BB577),
                                textColor: const Color(0xFFFCFCFC),
                              ),
                              const SizedBox(height: 15),
                              MyButton(
                                onTap: () {
                                  selectedRole = 'Student';
                                  context.read<LoginBloc>().add(
                                      CheckLoginStatusEvent(
                                          role: selectedRole!));
                                },
                                buttonText: 'Student',
                                color: const Color(0xFFFCFCFC),
                                textColor: const Color(0xFF3B3B3B),
                              ),
                            ],
                          ),
                        ),
                        if(state.isSubmitting)...[
                          const Center(child: CircularProgressIndicator()),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5)
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ]));
            },
          ),
        ),
      ),
    );
  }
}
