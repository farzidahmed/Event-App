import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/app_icons.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/common/custom_form_field.dart';
import 'package:llr/common/image_picker.dart';
import 'package:llr/gen/assets.gen.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final List<String> genderItems = ['Male', 'Female', 'Other'];
  String? selectedGender;
  final ValueNotifier<XFile?> imageNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _bioController.dispose();
    _countryController.dispose();
    _ageController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Personal Information",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () => showPickImageBottomSheet(context, imageNotifier),
                  child: ValueListenableBuilder<XFile?>(
                    valueListenable: imageNotifier,
                    builder: (context, image, child) {
                      if (image != null) {
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          width: 64,
                          height: 64,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: AppColor.c6944AB,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Image.file(
                            File(image.path),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return SvgPicture.asset(AppIcons.addPhoto);
                      }
                    },
                  ),
                ),

                UIHelper.verticalSpace(16.h),

                _inputLabel("Name"),
                UIHelper.verticalSpace(8.h),
                _textField(_nameController, "Enter your name"),
                UIHelper.verticalSpace(12.h),

                _inputLabel("Bio"),
                UIHelper.verticalSpace(8.h),
                _textField(_bioController, "Bio"),
                UIHelper.verticalSpace(12.h),

                _inputLabel("Gender"),
                UIHelper.verticalSpace(8.h),
                _genderWidget(),
                UIHelper.verticalSpace(12.h),

                _inputLabel("Country"),
                UIHelper.verticalSpace(8.h),
                _textField(_countryController, "Country"),
                UIHelper.verticalSpace(12.h),

                _inputLabel("Address"),
                UIHelper.verticalSpace(8.h),
                _textField(_addressController, "Address"),
                UIHelper.verticalSpace(12.h),

                _inputLabel("Age"),
                UIHelper.verticalSpace(8.h),
                _textField(
                  _ageController,
                  "Age",
                  inputType: TextInputType.number,
                ),
                UIHelper.verticalSpace(24.h),

                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (imageNotifier.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a profile image"),
                          ),
                        );
                        return;
                      }

                      updatPorifile(
                        File(imageNotifier.value!.path),
                        _nameController.text,
                        _addressController.text,
                        _countryController.text,
                        _ageController.text,
                        selectedGender ?? '',
                      );
                    }
                  },
                  btnName: 'Save Info',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(text, style: TextFontStyle.headline14w500cDFE3E8Montserrat),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String hint, {
    TextInputType inputType = TextInputType.text,
  }) {
    return CustomFormField(
      hintText: hint,
      controller: controller,
      textInputAction: TextInputAction.next,
      inputType: inputType,
    );
  }

  Widget _genderWidget() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColor.c6944AB, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColor.c212B36, width: 1.w),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      hint: Text(
        'Gender',
        style: TextFontStyle.headline14w400c637381Montserrat,
      ),
      items:
          genderItems
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextFontStyle.headline14w400cDFE3E8Montserrat,
                  ),
                ),
              )
              .toList(),
      validator: (value) => value == null ? 'Please select gender.' : null,
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
      onSaved: (value) {
        selectedGender = value!;
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: IconStyleData(icon: SvgPicture.asset(Assets.icons.down)),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.c6944AB,
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  void updatPorifile(
    File avatar,
    String name,
    String address,
    String country,
    String age,
    String gender,
  ) async {
    profileUpdateRxObj
        .editProfile(
          // profileImage: XFile(avatar.path),
          name: name,
          // address: address,
          sex: gender,
          country: country,
          age: age,
          image: null,
          bio: '',
        )
        .waitingForSucess()
        .then((success) {
          NavigationService.navigateToReplacementUntil(Routes.navigationScreen);
        });
  }
}
