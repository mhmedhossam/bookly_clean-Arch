import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:bookia/features/cartlist/presentation/cubit/card_cubit.dart';
import 'package:bookia/features/cartlist/presentation/cubit/card_states.dart';
import 'package:bookia/core/helper/governmentmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceYOrder extends StatelessWidget {
  dynamic total;
  PlaceYOrder({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();

    return BlocListener<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is PlaceOrderLoadingState) {
          showloadingDialog(context);
        } else if (state is PlaceOrderSucceedState) {
          Navigation.pop(context);
          Navigation.pushNamedTo(context, Routes.successView);
        } else if (state is PlaceOrderFailureState) {
          Navigation.pop(context);
          showMyDialog(context, state.message ?? "");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomBackButton(),
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: cubit.formkey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Place Your Order ", style: TextStyles.textStyle30),
                  Gap(10),
                  Text(
                    "Don't worry! It occurs. Please enter the email address linked with your account.",
                    style: TextStyles.textStyle16.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Gap(30),
                  CustomTextField(
                    keyboardType: TextInputType.name,

                    controller: cubit.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your Full Name";
                      }
                      return null;
                    },
                    hintText: "Full Name",
                  ),
                  Gap(10),

                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    controller: cubit.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your email";
                      } else if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                      ).hasMatch(value)) {
                        return "please enter a valid email";
                      }
                      return null;
                    },
                    hintText: " Email",
                  ),
                  Gap(10),

                  CustomTextField(
                    keyboardType: TextInputType.streetAddress,

                    controller: cubit.address,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your Address";
                      }
                      return null;
                    },
                    hintText: "Address",
                  ),
                  Gap(10),

                  CustomTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.phone,
                    controller: cubit.phone,
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
                  Gap(10),

                  CustomTextField(
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) {
                          var cubit = context.read<CartCubit>();
                          List<Governmentmodel> govListModels =
                              Governmentmodel.governListModels();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 4,
                                  width: 40,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                Text(
                                  "Select your Governorate",
                                  style: TextStyles.textStyle18,
                                ),
                                const SizedBox(height: 10),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: govListModels.length,
                                    itemBuilder: (_, i) {
                                      return ListTile(
                                        leading: Icon(Icons.location_on),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        title: Text(
                                          govListModels[i].governorateNameEn!,
                                        ),
                                        onTap: () {
                                          cubit.governorate.text =
                                              govListModels[i]
                                                  .governorateNameEn!;
                                          cubit.governorateId =
                                              govListModels[i].id;
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },

                    keyboardType: TextInputType.name,
                    readOnly: true,
                    controller: cubit.governorate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please choose your government";
                      }
                      return null;
                    },
                    hintText: (cubit.governorate.text).isEmpty
                        ? "Governorate"
                        : cubit.governorate.text,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("total: ", style: TextStyles.textStyle18),

                    Text("\$ ${total ?? 0} ", style: TextStyles.textStyle18),
                  ],
                ),
                MainButton(
                  onPressed: () {
                    if (cubit.formkey.currentState!.validate()) {
                      User user = User(
                        address: cubit.address.text,
                        phone: cubit.phone.text,
                        userEmail: cubit.email.text,
                        userName: cubit.name.text,
                        governorateId: cubit.governorateId,
                      );
                      cubit.submitOrder(user);
                    }
                  },
                  text: "Submit Order",
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.backgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSimpleDialog extends StatelessWidget {
  final BuildContext context;
  const CustomSimpleDialog({super.key, required this.context});

  @override
  Widget build(_) {
    var cubit = context.read<CartCubit>();
    return SimpleDialog(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.amber,
      backgroundColor: Colors.amber,
      // title: Text("select your Government", style: TextStyles.textStyle18),
      children: [
        Container(
          margin: EdgeInsets.all(5),
          height: 250,
          width: 200,
          child: ListView.builder(
            itemCount: Governmentmodel.governListModels().length,
            itemBuilder: (_, i) {
              List<Governmentmodel> govListModels =
                  Governmentmodel.governListModels();
              return GestureDetector(
                onTap: () {
                  cubit.governorate.text = govListModels[i].governorateNameEn!;
                  Navigation.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        govListModels[i].governorateNameEn!,
                        style: TextStyles.textStyle20.copyWith(),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
