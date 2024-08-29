import 'package:app_for_testing/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class ProfDutiesPage extends StatelessWidget {
  const ProfDutiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 4),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.menu_rounded,
                            size: 30, color: Color(0xFF3B3B3B))),
                    const Spacer(),
                    const MyAppBar(role: 'Professor')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
