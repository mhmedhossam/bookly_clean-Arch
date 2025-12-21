import 'dart:io';

import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';
import 'package:bookia/features/profile/domain/usecases/get_my_orders_usecase.dart';
import 'package:bookia/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit({
    required this.getMyOrdersUseCase,
    required this.updateProfileUseCase,
  }) : super(ProfileInitialState());
  List<Order>? orders;
  final formkey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  GetMyOrdersUseCase getMyOrdersUseCase;
  UpdateProfileUseCase updateProfileUseCase;
  File? image;
  initData() {
    var user = SharedPref.getUserData() as AuthUSer;

    phoneController.text = user.phone ?? "";
    addressController.text = user.address ?? "";
    nameController.text = user.name ?? "";
  }

  getMyOrders() async {
    emit(ProfileLoadingState());

    var res = await getMyOrdersUseCase.call();

    res.fold(
      (l) {
        emit(ProfileFailureState(message: l.errorMessage ?? ""));
      },
      (r) {
        emit(ProfileSuccessState());
        orders = r.orders;
      },
    );
  }

  updateMyProfile() async {
    emit(ProfileLoadingState());
    var res = await updateProfileUseCase.call(
      nameController.text,
      addressController.text,
      phoneController.text,
    );

    res.fold(
      (l) {
        emit(ProfileFailureState(message: l.errorMessage));
      },
      (r) {
        emit(ProfileSuccessState());
      },
    );
  }
}
