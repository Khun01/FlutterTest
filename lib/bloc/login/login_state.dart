class LoginState {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? failureMessage;
  final bool hasFailed;
  final String? role;

  bool get isEmailNotEmpty => email.isNotEmpty;
  bool get isPasswordNotEmpty => password.isNotEmpty;
  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    required this.email,
    required this.password,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    this.failureMessage,
    required this.hasFailed,
    required this.role
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      failureMessage: '',
      hasFailed: false,
      role: null,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? failureMessage,
    bool? hasFailed,
    String? role,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      failureMessage: failureMessage ?? this.failureMessage,
      hasFailed: hasFailed ?? this.hasFailed,
      role: role ?? this.role
    );
  }
}
