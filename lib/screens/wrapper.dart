import 'package:app_for_testing/components/my_drawer.dart';
import 'package:app_for_testing/screens/professor/prof_duties_page.dart';
import 'package:app_for_testing/screens/professor/prof_home_page.dart';
import 'package:app_for_testing/screens/professor/prof_profile_page.dart';
import 'package:app_for_testing/screens/students/student_home_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final String role;

  const Wrapper({
    super.key,
    required this.role,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
                index: selectedIndex,
                children: widget.role == 'Professor'
                    ? const [
                        ProfHomePage(),
                        ProfDutiesPage(),
                        ProfProfilePage()
                      ]
                    : const [
                        StudentHomePage(),
                        // StudeD(),
                        // StudProfilePage(),
                      ]),
            Positioned(
              left: 0,
              right: 0,
              bottom: 25,
              child: Container(
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0x303B3B3B)),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 6))
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BottomNavigationBar(
                    selectedItemColor: const Color(0xFF8CC9A6),
                    unselectedItemColor: const Color(0xFF3B3B3B),
                    selectedLabelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    items: [
                      BottomNavigationBarItem(
                          label: 'Home',
                          icon: selectedIndex == 0
                              ? const ImageIcon(
                                  AssetImage('assets/images/home_clicked.png'),
                                  color: Color(0xFFA3D9A5))
                              : const ImageIcon(
                                  AssetImage('assets/images/home.png'))),
                      BottomNavigationBarItem(
                          label: 'Duties',
                          icon: selectedIndex == 1
                              ? const ImageIcon(
                                  AssetImage(
                                      'assets/images/duties_clicked.png'),
                                  color: Color(0xFFA3D9A5))
                              : const ImageIcon(
                                  AssetImage('assets/images/duties.png'))),
                      BottomNavigationBarItem(
                          label: 'Profile',
                          icon: selectedIndex == 2
                              ? const ImageIcon(
                                  AssetImage(
                                      'assets/images/profile_clicked.png'),
                                  color: Color(0xFFA3D9A5))
                              : const ImageIcon(
                                  AssetImage('assets/images/profile.png'))),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (int index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            if (widget.role == 'Professor')
              Positioned(
                bottom: 125,
                right: 15,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: const Color(0x303B3B3B)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 6))
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      // log('Icon add is clikced');
                    },
                    child: const Icon(
                      Icons.add_rounded,
                      size: 40,
                      color: Color(0xFF6BB577),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
