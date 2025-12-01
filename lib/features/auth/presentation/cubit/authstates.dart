abstract class Authstates {}

class InitialState extends Authstates {}

class Authloading extends Authstates {}

class AuthSuccessed extends Authstates {}

class AuthFailure extends Authstates {
  String errorMessage;
  AuthFailure({required this.errorMessage});
}

class OtpSuccees extends Authstates {}
