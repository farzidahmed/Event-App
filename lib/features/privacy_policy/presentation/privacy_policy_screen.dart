import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/features/privacy_policy/model/privacy_policy_response.dart';
import 'package:llr/networks/api_access.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    privacyPolicyRxObj.privacyPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c0E0F11,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.cFFFFFF),
        title: Text(
          "Privacy Policy",
          style: TextFontStyle.headline20w600cDFE3E8Montserrat,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            StreamBuilder(
              stream: privacyPolicyRxObj.getTermsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  PrivacyPolicyResponse response = snapshot.data;

                  return HtmlWidget(
                    response.data?.description ?? 'No description',
                    textStyle: TextFontStyle.headline14w500cA7B0B9Montserrat,
                    customStylesBuilder: (element) {
                      if (element.classes.contains('highlight')) {
                        return {'color': 'blue'};
                      }
                      return null;
                    },
                    customWidgetBuilder: (element) {
                      if (element.attributes['foo'] == 'bar') {
                        // Render a custom widget if needed
                      }
                      return null;
                    },

                    renderMode: RenderMode.column,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
