import 'dart:developer';
import 'package:app_for_testing/bloc/logout/logout_event.dart';
import 'package:app_for_testing/bloc/logout/logout_state.dart';
import 'package:app_for_testing/services/auth_services.dart';
import 'package:app_for_testing/services/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState>{
  final AuthServices authServices; 
  LogoutBloc({required this.authServices}) : super(LogoutInitial()){
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<LogoutState> emit) async{
    emit(LogoutLoading());
    try{
      await Future.delayed(const Duration(seconds: 2));
      await authServices.logout();
      await Storage.deleteProfData();
      emit(LogoutSuccess());
    }catch(error){
      log('Logout Failed: ${error.toString()}');
      emit(LogoutFailure(error: error.toString()));
    }
  }
}