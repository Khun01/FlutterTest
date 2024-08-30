import 'dart:ui';

import 'package:app_for_testing/bloc/login/login_bloc.dart';
import 'package:app_for_testing/bloc/logout/logout_bloc.dart';
import 'package:app_for_testing/bloc/logout/logout_event.dart';
import 'package:app_for_testing/bloc/logout/logout_state.dart';
import 'package:app_for_testing/components/my_button.dart';
import 'package:app_for_testing/screens/landing_page.dart';
import 'package:app_for_testing/services/auth_services.dart';
import 'package:app_for_testing/services/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LogoutBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is LogoutSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LandingPage()));
          }
        },
        builder: (context, state) {
          return Dialog(
            child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                  margin: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFCFCFC),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/upang_logo.png',
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Are you sure you want\nto logged out?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B)),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 40),
                                side: const BorderSide(
                                  color: Color(0xFF3B3B3B),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {
                                BlocProvider.of<LogoutBloc>(context)
                                    .add(LogoutButtonPressed());
                              },
                              child: Text(
                                'Yes',
                                style: GoogleFonts.nunito(
                                    color: const Color(0xFF3B3B3B)),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6BB577),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 40)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'No',
                                style: GoogleFonts.nunito(
                                    color: const Color(0xFFFCFCFC)),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                if (state is LogoutLoading) ...[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(28)),
                    ),
                  ),
                  const Positioned(
                      top: 120,
                      bottom: 120,
                      left: 130,
                      right: 130,
                      child: CircularProgressIndicator(
                        color: Color(0xFF3B3B3B),
                      )),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
