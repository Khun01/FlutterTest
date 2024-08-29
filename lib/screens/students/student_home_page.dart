import 'package:app_for_testing/bloc/logout/logout_bloc.dart';
import 'package:app_for_testing/bloc/logout/logout_event.dart';
import 'package:app_for_testing/bloc/logout/logout_state.dart';
import 'package:app_for_testing/screens/landing_page.dart';
import 'package:app_for_testing/services/auth_services.dart';
import 'package:app_for_testing/services/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHomePage extends StatelessWidget {

  const StudentHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) =>
          LogoutBloc(authServices: AuthServices(apiUrl: baseUrl)),
      child: Scaffold(
        body: BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if(state is LogoutFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error))
              );
            }else if(state is LogoutSuccess){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const LandingPage())
              );
            }
          },
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    
                  ]),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 160),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<LogoutBloc, LogoutState>(
                    builder: (context, state){
                      return state is LogoutLoading ? const Center(child: CircularProgressIndicator()): 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LogoutBloc>(context).add(
                              LogoutButtonPressed()
                            );
                          },
                          style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.black)
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 13),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                          )
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
