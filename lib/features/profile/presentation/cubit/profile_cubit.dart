import 'dart:io';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/response/auth_response/user.dart';
import 'package:bookia/features/profile/data/models/response/get_profile_response/get_profile_response.dart';
import 'package:bookia/features/profile/data/models/response/response_order_history/order.dart';
import 'package:bookia/features/profile/data/models/response/response_order_history/response_order_history.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  late ResponseOrderHistory orderRes;
  List<Order>? orders;
  final formkey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  File? image;
  initData() {
    var user = SharedPref.getUserData() as AuthUSer;

    phoneController.text = user.phone ?? "";
    addressController.text = user.address ?? "";
    nameController.text = user.name ?? "";
  }

  getMyOrders() async {
    emit(ProfileLoadingState());

    orderRes = await ProfileRepo.getMyOrder();
    if (orderRes.status != 200) {
      emit(ProfileFailureState(message: orderRes.message ?? ""));
    } else {
      emit(ProfileSuccessState());
      orders = orderRes.data!.orders!;
      return orders;
    }
  }

  updateMyProfile() async {
    emit(ProfileLoadingState());
    GetProfileResponse res = await ProfileRepo.updateProfile(
      name: nameController.text,
      address: addressController.text,
      phone: phoneController.text,
    );

    if (res.status != 200) {
      emit(ProfileFailureState(message: "error please try again"));
    } else {
      emit(ProfileSuccessState());
    }
  }
}
