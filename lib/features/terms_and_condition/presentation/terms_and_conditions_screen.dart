import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/features/terms_and_condition/model/term_and_conditon_response.dart';
import 'package:llr/networks/api_access.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    super.initState();
    termsAndConditionRxObj.termsAndCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c0E0F11,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColor.cFFFFFF),
        title: Text(
          "Terms & Conditions",
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
              stream: termsAndConditionRxObj.getTermsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  TermsAndCodnition response = snapshot.data;

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
