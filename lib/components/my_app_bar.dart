// lib/components/custom_app_bar.dart
import 'package:app_for_testing/bloc/userdata/user_bloc.dart';
import 'package:app_for_testing/bloc/userdata/user_event.dart';
import 'package:app_for_testing/bloc/userdata/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String role;

  const MyAppBar({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataBloc()..add(LoadUserData()),
      child: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDataLoaded) {
            return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Welcome',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0x803B3B3B),
                              ),
                            ),
                            Text(
                              state.firstName ?? 'N/A',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const CircleAvatar(
                          backgroundColor: Color(0x80A3D9A5),
                          radius: 25,
                          child: Icon(Icons.person),
                        ),
                      ],
                    ));
          } else if (state is UserDataError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
