import 'package:app_for_testing/bloc/userdata/user_event.dart';
import 'package:app_for_testing/bloc/userdata/user_state.dart';
import 'package:app_for_testing/services/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()){
    on<LoadUserData>(_onLoadUserData);
  }

  void _onLoadUserData(LoadUserData event, Emitter<UserDataState> emit) async {
    emit(UserDataLoading());
    try {
      final userData = await Storage.getProfData();
      final name = userData['name'] ?? 'N/A';
      final token = userData['token'] ?? 'N/A';
      final firstName = userData['firstName'] ?? 'N/A';
      emit(UserDataLoaded(name: name, token: token, firstName: firstName));
    } catch (e) {
      emit(UserDataError(message: e.toString()));
    }
  }

}