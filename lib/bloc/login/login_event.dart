abstract class LoginEvent{}

class LoginEmailChanged extends LoginEvent{
  final String email;

  LoginEmailChanged({required this.email});
}

class LoginPassChanged extends LoginEvent{
  final String password;

  LoginPassChanged({required this.password});
}

class LoginSubmitted extends LoginEvent{
  final String role;

  LoginSubmitted({required this.role});
}

class CheckLoginStatusEvent extends LoginEvent{
  final String role;

  CheckLoginStatusEvent({required this.role});
}

class ResetLoginEvent extends LoginEvent{
  
}