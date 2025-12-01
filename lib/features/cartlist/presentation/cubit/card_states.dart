abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartSucceedState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartFailureState extends CartStates {
  final String? message;
  CartFailureState({this.message});
}

class CheckoutInitialState extends CartStates {}

class CheckoutSucceedState extends CartStates {}

class CheckoutLoadingState extends CartStates {}

class CheckoutFailureState extends CartStates {
  final String? message;
  CheckoutFailureState({this.message});
}

class PlaceOrderSucceedState extends CartStates {}

class PlaceOrderLoadingState extends CartStates {}

class PlaceOrderFailureState extends CartStates {
  final String? message;
  PlaceOrderFailureState({this.message});
}
