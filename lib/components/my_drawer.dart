import 'package:app_for_testing/bloc/userdata/user_bloc.dart';
import 'package:app_for_testing/bloc/userdata/user_event.dart';
import 'package:app_for_testing/bloc/userdata/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool showSecondContainer = false;

  void toggleSecondContainer() {
    setState(() {
      showSecondContainer = !showSecondContainer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataBloc()..add(LoadUserData()),
      child: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if(state is UserDataLoading){
            return const Center(child: CircularProgressIndicator());
          }else if(state is UserDataLoaded){
            return SafeArea(
              child: Row(
                children: [
                  Container(
                    width: 100,
                    color: const Color(0xFFFCFCFC),
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.only(
                          top: 24,
                          bottom: 24,
                          left: 16,
                          right: showSecondContainer ? 0 : 16),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              toggleSecondContainer();
                            },
                            child: Image.asset(
                              'assets/images/upang_logo.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(color: Color(0xFF6BB577)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Ionicons.reader,
                                  color: Color(0xFF6BB577))),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.people,
                                  color: Color(0xFF6BB577))),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Ionicons.chatbubble_ellipses,
                                  color: Color(0xFF6BB577))),
                          const Divider(color: Color(0xFF6BB577)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_rounded,
                                  color: Color(0xFF6BB577))),
                          const Divider(color: Color(0xFF6BB577)),
                          const Spacer(),
                          const Divider(color: Color(0xFF6BB577)),
                          const SizedBox(height: 16),
                          const CircleAvatar(
                            backgroundColor: Color(0xFF6BB577),
                            radius: 20,
                            child: Icon(
                              Ionicons.person,
                              color: Color(0xFF3B3B3B),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: showSecondContainer ? 150 : 0,
                    color: const Color(0xFFFCFCFC),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 22.1),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Help, isKo',
                              style: GoogleFonts.nunito(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 15.9),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: showSecondContainer ? 134 : 0,
                              child: const Divider(color: Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 17),
                            Text(
                              'HK Students',
                              style: GoogleFonts.nunito(
                                  fontSize: 12, color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 31),
                            Text(
                              'Accepted HK Students',
                              style: GoogleFonts.nunito(
                                  fontSize: 12, color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 31),
                            Text(
                              'Message',
                              style: GoogleFonts.nunito(
                                  fontSize: 12, color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 14),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: showSecondContainer ? 134 : 0,
                              child: const Divider(color: Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 17),
                            Text(
                              'Notifications',
                              style: GoogleFonts.nunito(
                                  fontSize: 12, color: const Color(0xFF3B3B3B)),
                            ),
                            const SizedBox(height: 14),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: showSecondContainer ? 134 : 0,
                              child: const Divider(color: Color(0xFF6BB577)),
                            ),
                            const Spacer(),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: showSecondContainer ? 134 : 0,
                              child: const Divider(color: Color(0xFF6BB577)),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  state.firstName ?? 'N/A',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3B3B3B)),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Ionicons.log_out,
                                        color: Color(0xFF6BB577)))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is UserDataError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
