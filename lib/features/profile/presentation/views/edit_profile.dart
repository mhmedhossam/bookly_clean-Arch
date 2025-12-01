import 'dart:io';

import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? imagePicker;
  File? image;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Gap(10), CustomBackButton()],
        ),
        centerTitle: true,
        title: const Text("Edit Profile", style: TextStyles.textStyle20),
      ),
      body: BlocListener<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            showloadingDialog(context);
          } else if (state is ProfileSuccessState) {
            Navigation.pop(context);
            showMyDialog(
              context,
              "Profile updated successfully",
              Dialogtype.success,
            );
            Navigation.pop(context);
          } else if (state is ProfileFailureState) {
            context.pop();
            showMyDialog(context, "Update failed", Dialogtype.error);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
              key: cubit.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(30),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: image != null
                        ? FileImage(image!)
                        : const AssetImage('assets/images/welcome.png')
                              as ImageProvider,

                    backgroundColor: AppColors.greyColor,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.backgroundColor,
                        child: IconButton(
                          onPressed: () async {
                            imagePicker = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );
                            if (imagePicker != null) {
                              final bytes = await File(
                                imagePicker?.path ?? "",
                              ).readAsBytes();
                              SharedPref.setImage(bytes);
                              setState(() {
                                image = File(imagePicker?.path ?? "");
                              });
                            }
                          },
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(50),
                  CustomTextField(
                    controller: cubit.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    hintText: 'Name',
                  ),
                  const Gap(20),

                  CustomTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.phone,
                    controller: cubit.phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your phone";
                      } else if (!RegExp(
                        r'^01[0125][0-9]{8}$',
                      ).hasMatch(value)) {
                        return "please enter valid phone";
                      }
                      return null;
                    },
                    hintText: "phone",
                  ),
                  const Gap(20),

                  // Address field
                  CustomTextField(
                    controller: cubit.addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                    hintText: 'Address',
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: MainButton(
            onPressed: () {
              if (cubit.formkey.currentState!.validate()) {
                cubit.updateMyProfile();
              }
            },
            text: "Update Profile",
            bgColor: AppColors.primaryColor,
            textColor: AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }
}
