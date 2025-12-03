import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/authstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authtcubit extends Cubit<Authstates> {
  final formkey = GlobalKey<FormState>();
  final confirmpasswordController = TextEditingController();
  final otpController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  LoginUseCase loginUseCase;
  RegisterUseCase registerUseCase;
  Authtcubit({required this.loginUseCase, required this.registerUseCase})
    : super(InitialState());

  register() async {
    if (isClosed) return;

    emit(Authloading());
    var res = await registerUseCase.call(
      AuthDataRequesr(
        email: emailController.text,
        password: passwordController.text,
        confirmPass: confirmpasswordController.text,
        name: userNameController.text,
      ),
    );
    if (isClosed) return;

    res.fold(
      (l) => emit(AuthFailure(errorMessage: l.errorMessage)),
      (r) => emit(AuthSuccessed()),
    );
  }

  login() async {
    if (isClosed) return;

    emit(Authloading());

    var res = await loginUseCase.call(
      AuthDataRequesr(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    if (isClosed) return;

    res.fold(
      (left) {
        emit(AuthFailure(errorMessage: left.errorMessage));
      },
      (right) {
        emit(AuthSuccessed());
      },
    );
  }

  fogetPassword() async {
    if (isClosed) return;

    emit(Authloading());

    var res = await AuthRepo.forgetPassword(
      AuthDataRequesr(email: emailController.text),
    );
    if (isClosed) return;

    if (res.status != 200) {
      emit(AuthFailure(errorMessage: res.message!));
    } else {
      emit(AuthSuccessed());
    }
  }

  otpVerfyy(String email) async {
    if (isClosed) return;

    emit(Authloading());

    var res = await AuthRepo.otpVerifyy(
      AuthDataRequesr(email: email, otp: otpController.text),
    );
    if (isClosed) return;

    if (res.status != 200) {
      emit(AuthFailure(errorMessage: res.message!));
    } else {
      emit(AuthSuccessed());
    }
  }

  setNewPassword(String otp) async {
    if (isClosed) return;

    emit(Authloading());
    var res = await AuthRepo.setNewPassword(
      AuthDataRequesr(
        otp: otp,
        newpassword: passwordController.text,
        newconfirmPass: confirmpasswordController.text,
      ),
    );
    if (isClosed) return;

    if (res.status != 200) {
      emit(AuthFailure(errorMessage: res.message!));
    } else {
      emit(AuthSuccessed());
    }
  }
}
