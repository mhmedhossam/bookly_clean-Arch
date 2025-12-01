abstract class HomeStates {}

class InitialState extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSucceed extends HomeStates {
  String? message;

  HomeSucceed({this.message});
}

class HomeFailure extends HomeStates {
  final String? message;

  HomeFailure({required this.message});
}
