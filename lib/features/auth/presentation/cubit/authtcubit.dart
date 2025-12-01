import 'package:bookia/features/auth/data/models/request/auth_data.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
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
  Authtcubit() : super(InitialState());

  register() async {
    if (isClosed) return;

    emit(Authloading());
    var res = await AuthRepo.register(
      AuthDataRequesr(
        email: emailController.text,
        password: passwordController.text,
        confirmPass: confirmpasswordController.text,
        name: userNameController.text,
      ),
    );
    if (isClosed) return;

    if (res.status != 201) {
      emit(AuthFailure(errorMessage: res.message!));
    } else {
      emit(AuthSuccessed());
    }
  }

  login() async {
    try {
      if (isClosed) return;

      emit(Authloading());

      var res = await AuthRepo.login(
        AuthDataRequesr(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      if (isClosed) return;

      if (res.status != 200) {
        emit(AuthFailure(errorMessage: res.message!));
      } else {
        emit(AuthSuccessed());
      }
    } on Exception catch (e) {
      emit(AuthFailure(errorMessage: "hosooo"));
    }
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
