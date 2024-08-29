import 'package:equatable/equatable.dart';

abstract class UserDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserData extends UserDataEvent {}