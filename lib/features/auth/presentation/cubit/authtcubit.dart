import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/usecases/forget_pass_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/setNpass_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/authstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authtcubit extends Cubit<AuthStates> {
  final formKey = GlobalKey<FormState>();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  LoginUseCase loginUseCase;
  RegisterUseCase registerUseCase;
  OtpVerifyUseCase otpVerifyUseCase;
  ForgetPassUseCase forgetPassUseCase;
  SetNPassUseCase setNPassUseCase;
  Authtcubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgetPassUseCase,
    required this.otpVerifyUseCase,
    required this.setNPassUseCase,
  }) : super(InitialState());

  register() async {
    if (isClosed) return;

    emit(AuthLoading());
    var res = await registerUseCase.call(
      AuthDataRequest(
        email: emailController.text,
        password: passwordController.text,
        confirmPass: confirmPasswordController.text,
        name: userNameController.text,
      ),
    );
    if (isClosed) return;

    res.fold(
      (l) => emit(AuthFailure(errorMessage: l.errorMessage)),
      (r) => emit(AuthSucceeded()),
    );
  }

  login() async {
    if (isClosed) return;

    emit(AuthLoading());

    var res = await loginUseCase.call(
      AuthDataRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    if (isClosed) return;

    res.fold(
      (l) {
        emit(AuthFailure(errorMessage: l.errorMessage));
      },
      (r) {
        emit(AuthSucceeded());
      },
    );
  }

  forgetPassword() async {
    if (isClosed) return;

    emit(AuthLoading());

    var res = await forgetPassUseCase.call(
      AuthDataRequest(email: emailController.text),
    );
    if (isClosed) return;

    res.fold(
      (l) {
        emit(AuthFailure(errorMessage: l.errorMessage));
      },
      (r) {
        emit(AuthSucceeded());
      },
    );
  }

  otpVerify(String email) async {
    if (isClosed) return;

    emit(AuthLoading());

    var res = await otpVerifyUseCase.call(
      AuthDataRequest(email: email, otp: otpController.text),
    );
    if (isClosed) return;

    res.fold(
      (l) {
        emit(AuthFailure(errorMessage: l.errorMessage));
      },
      (r) {
        emit(AuthSucceeded());
      },
    );
  }

  setNewPassword(String otp) async {
    if (isClosed) return;

    emit(AuthLoading());
    var res = await setNPassUseCase.call(
      AuthDataRequest(
        otp: otp,
        newPassword: passwordController.text,
        newConfirmPass: confirmPasswordController.text,
      ),
    );
    if (isClosed) return;

    res.fold(
      (l) {
        emit(AuthFailure(errorMessage: l.errorMessage));
      },
      (r) {
        emit(AuthSucceeded());
      },
    );
  }
}
