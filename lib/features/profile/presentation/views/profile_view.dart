import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';
import 'package:bookia/features/profile/domain/entities/response/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../widgets/custom_list_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var userData = SharedPref.getUserData() as AuthUSer;

    var userImage = SharedPref.getImage(height: 120, width: 120);

    print(" ${userData.address}");
    List<ProfileModel> profiles = [
      ProfileModel(
        title: "My Orders",
        onTap: () {
          Navigation.pushNamedTo(context, Routes.myOrderScreen);
        },
      ),
      ProfileModel(
        title: "Edit Profile",
        onTap: () {
          Navigation.pushNamedTo(context, Routes.editprofile).then((v) {
            if (!mounted) return;
            setState(() {});
          });
        },
      ),
      ProfileModel(
        title: "Reset Password",
        onTap: () {
          Navigation.pushNamedTo(context, Routes.updatePasswordScreen);
        },
      ),
      ProfileModel(title: "FAQ", onTap: () {}),
      ProfileModel(title: "Contact Us", onTap: () {}),
      ProfileModel(title: "Privacy & Terms", onTap: () {}),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: TextStyles.textStyle24),
        actions: [
          IconButton(
            onPressed: () {
              SharedPref.detete(SharedPref.ktoken);
              Navigation.pushNamedandRemoveUntilTo(
                context,
                Routes.welcomeScreen,
              );
              print("${SharedPref.getToken()}");
            },
            icon: SvgPicture.asset("assets/icons/Logout.svg"),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.darkGreyColor,
                  radius: 50,
                  backgroundImage: userImage != null
                      ? userImage.image
                      : NetworkImage(userData.image ?? ""),
                ),
                Gap(10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userData.name ?? "",
                        style: TextStyles.textStyle20,
                        maxLines: 1,
                      ),
                      Text(
                        maxLines: 1,
                        userData.email ?? "",
                        style: TextStyles.textStyle14.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(35),

            Expanded(
              child: ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      CustomListTile(
                        title: profiles[i].title,
                        onTap: profiles[i].onTap,
                      ),
                      Gap(10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
