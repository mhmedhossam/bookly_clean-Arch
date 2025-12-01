abstract class WishlistState {}

class InitialState extends WishlistState {}

class LoadingState extends WishlistState {}

class SucceededState extends WishlistState {}

class FailureStates extends WishlistState {
  String? message;
  FailureStates({this.message});
}
