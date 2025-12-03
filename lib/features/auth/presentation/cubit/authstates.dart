abstract class AuthStates {}

class InitialState extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSucceeded extends AuthStates {}

class AuthFailure extends AuthStates {
  String errorMessage;
  AuthFailure({required this.errorMessage});
}

class OtpSuccees extends AuthStates {}
