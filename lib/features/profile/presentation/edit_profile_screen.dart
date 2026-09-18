import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/image_picker.dart';
import 'package:llr/features/profile/model/user_details_model.dart';
import 'package:llr/features/profile/presentation/widget/profile_image_picker.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/api_access.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  String? selectedCountry;
  String? selectedGender;
  final ValueNotifier<XFile?> imagePath = ValueNotifier<XFile?>(null);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // ---------------- BOTTOM SHEET ----------------

  // @override
  // void initState() {
  //   editUpdateData();
  //   super.initState();
  // }

  // void editUpdateData() {
  //   userDetailsRxObj.userDetails().then((data) {
  //     setState(() {
  //       _nameController.text = data.data?.name ?? "";
  //       _bioController.text = data.data?.bio ?? "";
  //       _emailController.text = data.data?.email ?? "";
  //       _countryController.text = data.data?.country ?? "";
  //       _genderController.text = data.data?.sex ?? "";
  //       _ageController.text = data.data?.age ?? "";
  //     });
  //   });
  // }

  // ---------------- UI BUILD ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Edit Account",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
      ),
      body: StreamBuilder(
        stream: userDetailsRxObj.allAlumbs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            UserDetailsModel? model = snapshot.data;

            _nameController.text = model?.data?.name ?? "";
            _bioController.text = model?.data?.bio ?? "";
            _emailController.text = model?.data?.email ?? "";
            _countryController.text = model?.data?.country ?? "";
            _genderController.text = model?.data?.sex ?? "";
            _ageController.text = model?.data?.age.toString() ?? "";
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // ---------------- PROFILE IMAGE ----------------
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: _showImagePicker,
                  //     child:
                  //     //  Stack(
                  //     //   children: [
                  //     //     CircleAvatar(
                  //     //       radius: 55.r,
                  //     //       backgroundColor: Colors.deepOrangeAccent.withValues(
                  //     //         alpha: 0.60,
                  //     //       ),
                  //     //       child: CircleAvatar(
                  //     //         radius: 52.r,
                  //     //         backgroundImage:
                  //     //             _profileImage != null
                  //     //                 ? FileImage(_profileImage!)
                  //     //                 : CustomNetworkImage(
                  //     //                       urls: model?.data?.avatar ?? "",
                  //     //                     )
                  //     //                     as ImageProvider,
                  //     //       ),
                  //     //     ),
                  //     //     Positioned(
                  //     //       bottom: 10,
                  //     //       right: 0,
                  //     //       child: Container(
                  //     //         height: 26.h,
                  //     //         width: 26.h,
                  //     //         decoration: BoxDecoration(
                  //     //           border: Border.all(color: AppColor.cFFFFFF),
                  //     //           color: const Color(0xFF9F4FFB),
                  //     //           shape: BoxShape.circle,
                  //     //         ),
                  //     //         child: Image.asset(Assets.images.editIcon.path),
                  //     //       ),
                  //     //     ),
                  //     //   ],
                  //     // ),
                  //   ),
                  // ),
                  ProfileImagePicker(
                    imageNotifier: imagePath,
                    placeholderUrl:
                        model?.data?.avatar?.isNotEmpty == true
                            ? model!.data!.avatar!
                            : "https://media.istockphoto.com/id/2221915585/vector/grey-avatar-icon-user-avatar-photo-icon-social-media-user-icon-vector.jpg?s=612x612&w=0&k=20&c=9CObBqL8r65oVfHE4hyEqpyb8FwK7VfDqF1qXD5YMz4=",
                    onTap: () {
                      showPickImageBottomSheet(context, imagePath);
                    },
                  ),
                  _label("Name"),
                  _textfield("Name", _nameController),

                  _label("Bio"),
                  _textfield("Bio", _bioController),

                  _label("Email"),
                  _textfield("Email", _emailController),

                  _label("Country"),
                  _textfield("Country", _countryController),

                  // _dropdown("Country", selectedCountry, (val) {
                  //   setState(() => selectedCountry = val);
                  // }),
                  _label("Gender"),
                  _textfield("Gender", _genderController),

                  // _dropdown("Gender", selectedGender, (val) {
                  //   setState(() => selectedGender = val);
                  // }),
                  _label("Age"),
                  _textfield("Age", _ageController),

                  const SizedBox(height: 30),

                  // ---------------- BUTTONS ----------------
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigationService.goBack;
                          },
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white38),
                            ),
                            child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            log("Profile Image ====> ${imagePath.value?.path}");
                            editProfile(
                              imagePath.value,
                              _nameController.text.toString(),
                              _bioController.text.toString(),
                              _emailController.text.toString(),
                              _genderController.text.toString(),
                              _countryController.text.toString(),
                              _genderController.text.toString(),
                              _ageController.text.toString(),
                            );
                          },
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: Color(0xFF9F4FFB),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                "Save Info",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  void editProfile(
    XFile? avatar,
    String name,
    String bio,
    String email,
    String sex,
    String country,
    String gender,
    String age,
  ) async {
    profileUpdateRxObj
        .editProfile(
          image: avatar != null ? File(avatar.path) : null,
          name: name,
          sex: sex,
          country: country,
          age: age,
          bio: bio,
        )
        .waitingForSucess()
        .then((success) {
          if (success) {
            ToastUtil.showSuccessMessage("Profile Update Successfully");
            userDetailsRxObj.userDetails();
            NavigationService.goBack;
          }
        });
  }

  // ---------------- LABEL ----------------
  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.w, top: 14.h),
      child: Text(
        text,
        style: TextFontStyle.headline12cffffroboto.copyWith(fontSize: 14.sp),
      ),
    );
  }

  // ---------------- TEXTFIELD ----------------
  Widget _textfield(String hint, TextEditingController controller) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColor.c000000.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Center(
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
          ),
        ),
      ),
    );
  }

  // ---------------- DROPDOWN ----------------
}
