import 'dart:async';
import 'dart:developer';
import 'package:app_for_testing/bloc/login/login_event.dart';
import 'package:app_for_testing/bloc/login/login_state.dart';
import 'package:app_for_testing/services/auth_services.dart';
import 'package:app_for_testing/services/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthServices authServices;

  LoginBloc({required this.authServices}) : super(LoginState.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPassChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<CheckLoginStatusEvent>(_checkLoginStatus);
    on<ResetLoginEvent>(_onResetLoginEvent);
  }

  void _checkLoginStatus(
      CheckLoginStatusEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(
          isSuccess: false, hasFailed: false, isSubmitting: false));
      if (event.role == 'Student') {
        // final userData = await Storage.getProfData();
        // final token = userData['token'];

        // if (token != null) {
        //   await Future.delayed(const Duration(seconds: 5));
        //   log('It has a token');
        //   emit(LoginSuccess());
        // } else {
        //   emit(LoginFailure(error: "Token is not availbale"));
        // }
        emit(state.copyWith(hasFailed: true, isSubmitting: false));
        log('Student');
      } else if (event.role == 'Professor') {
        emit(state.copyWith(isSubmitting: true));
        try {
          final userData = await Storage.getProfData();
          final token = userData['token'];

          if (token != null) {
            await Future.delayed(const Duration(seconds: 2));
            emit(state.copyWith(isSuccess: true, isSubmitting: false));
          } else {
            log('dont have a token professor');
            emit(state.copyWith(hasFailed: true, isSubmitting: false));
          }
        } catch (e) {
          emit(state.copyWith(failureMessage: e.toString()));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          failureMessage: 'Network Error',
          hasFailed: true,
          isSubmitting: false));
    }
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        email: event.email,
        isEmailValid: _validateEmail(event.email),
        hasFailed: false,
        failureMessage: null));
  }

  void _onPasswordChanged(LoginPassChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        password: event.password,
        isPasswordValid: _validatePassword(event.password),
        hasFailed: false,
        failureMessage: null));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.email.isNotEmpty || state.password.isNotEmpty) {
      if (state.isFormValid) {
        emit(state.copyWith(isSubmitting: true));
        try {
          if (event.role == 'Professor') {
            await Future.delayed(const Duration(seconds: 2));
            final response =
                await authServices.loginProf(state.email, state.password);
            final statusCode = response['statusCode'];
            final responseData = response['data'];
            if (statusCode == 200) {
              if (responseData != null) {
                final String token = responseData['token'];
                final String name = responseData['name'];

                final Map<String, dynamic> user = responseData['user'];
                final String id = user['id'].toString();
                final String firstName = user['first_name'];
                final String lastName = user['last_name'];
                final String birthday = user['birthday'];
                final String contactNumber = user['contact_number'];
                final String professorNumber = user['professor_number'];
                final String profileImg = user['profile_img'] ?? '';
                final String userId = user['user_id'].toString();

                await Storage.saveProfData(
                  id: id,
                  firstName: firstName,
                  lastName: lastName,
                  birthday: birthday,
                  contactNumber: contactNumber,
                  professorNumber: professorNumber,
                  profileImg: profileImg,
                  userId: userId,
                  token: token,
                  fullName: name,
                );

                log('Response data: $user');
                emit(state.copyWith(isSuccess: true, isSubmitting: false));
              }
            } else {
              String errorMessage;
              switch (statusCode) {
                case 401:
                  errorMessage = 'Email and password do not match our records';
                  break;
                case 403:
                  errorMessage = 'Not a professor';
                  break;
                default:
                  log('The status Code is $statusCode');
                  errorMessage = 'Network Error';
              }
              emit(state.copyWith(
                  hasFailed: true,
                  isSubmitting: false,
                  failureMessage: errorMessage));
            }
          }
        } catch (e) {
          emit(state.copyWith(
              isSubmitting: false,
              hasFailed: true,
              failureMessage: 'An unexpected error has occured'));
        }
      } else {
        emit(state.copyWith(
          isEmailValid: state.isEmailNotEmpty && state.isEmailValid,
          isPasswordValid: state.isPasswordNotEmpty && state.isPasswordValid,
        ));
      }
    } else {
      emit(state.copyWith(failureMessage: 'Please put your account first'));
    }
  }

  bool _validateEmail(String email) {
    // Implement your email validation logic here
    return email.contains('@');
  }

  bool _validatePassword(String password) {
    // Implement your password validation logic here
    return password.length > 6;
  }

  void _onResetLoginEvent(
      ResetLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isSubmitting: false));
  }
}
