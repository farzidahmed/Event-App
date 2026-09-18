import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_button.dart';
import 'package:llr/common/custom_form_field.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/features/help_and_support/model/faq_response.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/networks/api_access.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    faqRxObj.getFaq();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.cFFFFFF),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Help & Support",
          style: TextFontStyle.headline20w600cFFFFFFMontserrat,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              "Frequently Asked Questions",
              style: TextFontStyle.headline18w600cFFFFFFMontserrat,
            ),
            SizedBox(height: 16.h),
            StreamBuilder(
              stream: faqRxObj.faqList,
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const GenericListShimmer(itemCount: 4);
                } else if (snapShot.hasData) {
                  FaqResponse faqResponse = snapShot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: faqResponse.data!.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final data = faqResponse.data![index];
                      return Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            data.question ?? "",
                            style:
                                TextFontStyle.headline14w500cFFFFFFMontserrat,
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.cFFFFFF,
                          ),
                          childrenPadding: EdgeInsets.zero,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Text(
                                data.answer ?? "",
                                style:
                                    TextFontStyle
                                        .headline14w400cA7B0B9Montserrat,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 32.h),
            Text(
              "Contact Support",
              style: TextFontStyle.headline18w600cFFFFFFMontserrat,
            ),
            SizedBox(height: 8.h),
            Text(
              "Have a question or issue? Send us a message and we'll get back to you as soon as possible.",
              style: TextFontStyle.headline14w400cA7B0B9Montserrat,
            ),
            SizedBox(height: 20.h),
            CustomFormField(
              controller: _messageController,
              hintText: "Describe your issue or question...",
              maxline: 5,
              fillColor: AppColor.c22252D,
              borderRadius: 12.r,
            ),
            SizedBox(height: 24.h),
            CustomButton(
              onTap: () {
                contactMessageRxObj
                    .sendMessage(message: _messageController.text)
                    .waitingForSucess()
                    .then((success) {
                      if (success) {
                        _messageController.clear();
                        ToastUtil.showLongToast("Message sent successfully");
                      }
                    });
                log("message : ${_messageController.text}");
              },
              btnName: "Send Message",
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
