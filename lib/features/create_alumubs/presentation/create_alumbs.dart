import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/features/festival_details/model/fseive_all_model.dart';
import 'package:llr/helpers/loading_helper.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/helpers/toast.dart';
import 'package:llr/helpers/ui_helpers.dart';
import 'package:llr/networks/api_access.dart';
import 'package:path_provider/path_provider.dart';

class CreateAlbumScreen extends StatefulWidget {
  const CreateAlbumScreen({super.key});

  @override
  State<CreateAlbumScreen> createState() => _CreateAlbumScreenState();
}

class _CreateAlbumScreenState extends State<CreateAlbumScreen> {
  bool isPublic = false;
  bool isSingleDay = true;

  File? mainImage;
  final ImagePicker picker = ImagePicker();

  final TextEditingController _datePicker = TextEditingController();
  final TextEditingController _favset = TextEditingController();
  final TextEditingController _experience = TextEditingController();
  final TextEditingController _story = TextEditingController();
  final TextEditingController _location = TextEditingController();

  String? selectedDay;
  String? selectedFestival;
  String? selectedFestivalId;

  List<File> mediaFiles = [];

  @override
  void initState() {
    allFestiveRxObj.all();
    super.initState();
  }

  // ============================================================
  // SAFE FILE COPY (Fixes Android 13, iOS HEIC, FilePicker issues)
  // ============================================================
  Future<File> toSafeFile(File file) async {
    final dir = await getTemporaryDirectory();
    final newPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    return await file.copy(newPath);
  }

  // ============================================================
  // PICK MAIN IMAGE
  // ============================================================
  Future<void> pickMainImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        mainImage = File(image.path);
      });
    }
  }

  // ============================================================
  // PICK MULTIPLE MEDIA FIXED (Handles path == null)
  // ============================================================
  Future<void> pickMediaFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
      withData: true,
    );

    if (result != null) {
      final tempDir = await getTemporaryDirectory();
      final safeFiles = <File>[];

      for (var file in result.files) {
        if (file.bytes != null) {
          final tempFile = File("${tempDir.path}/${file.name}");
          await tempFile.writeAsBytes(file.bytes!);
          safeFiles.add(tempFile);
        } else if (file.path != null) {
          safeFiles.add(File(file.path!));
        }
      }

      setState(() => mediaFiles.addAll(safeFiles));
    }
  }

  // ============================================================
  // SAVE ALBUM (FULL FIX — safe files + XFile conversion)
  // ============================================================
  Future<XFile> toSafeXFile(File file) async {
    if (!await file.exists()) {
      throw Exception("File does not exist: ${file.path}");
    }
    if (await file.length() == 0) {
      throw Exception("File is empty: ${file.path}");
    }
    final dir = await getTemporaryDirectory();
    final newPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final safeFile = await file.copy(newPath);
    return XFile(safeFile.path);
  }

  // ============================================================
  // SAVE ALBUM
  // ============================================================
  Future<void> saveAlbum() async {
    try {
      if (mainImage == null) {
        ToastUtil.showLongToast("Please select a main image");
        return;
      }
      if (selectedFestivalId == null) {
        ToastUtil.showLongToast("Please select a festival");
        return;
      }

      // Convert main image to safe XFile
      final safeMainImage = await toSafeXFile(mainImage!);

      // Convert additional media files to safe XFiles
      await Future.wait(mediaFiles.map((file) => toSafeXFile(file)));

      // Call API
      await createAlumbsRxObj
          .createPost(
            favouriteSet: _favset.text,
            favouriteDay: selectedDay ?? "",
            description: _story.text,
            dayType: isSingleDay ? "single-day" : "none",
            festiveDate: _datePicker.text,
            campExperience: _experience.text,
            festiveStory: _story.text,
            dairyEntry: "I love this festival",
            status: isPublic,
            festType: "previous",
            image: safeMainImage,
            festivalName: selectedFestival ?? "",
            festivalId: selectedFestivalId ?? "",
            locations: _location.text,
            // documents: safeDocs, // <-- now included
          )
          .waitingForSucess()
          .then((success) {
            if (success) {
              alumbsRxObj.myAlumbs(0);
              //  alumbsRxObj.myAlumbs(1);
              // alumbsRxObj.myAlumbs(2);
              NavigationService.goBack;
              ToastUtil.showSuccessMessage("Album Created Successfully!");
            }
          });
    } catch (e, st) {
      print("Error saving album: $e\n$st");
      ToastUtil.showErrorMessage("Failed to create album: ${e.toString()}");
    }
  }

  // ============================================================
  // UI BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111013),
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _festivalSection(),
            UIHelper.verticalSpace(16),
            _experienceSection(),
            UIHelper.verticalSpace(16),
            _mediaSection(),
            UIHelper.verticalSpace(16),
            _privacySection(),
            const SizedBox(height: 24),
            _buttons(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COMPONENTS
  // ============================================================

  AppBar _appBar() {
    return AppBar(
      backgroundColor: const Color(0xff111013),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Create Album",
        style: TextFontStyle.headline24w400cFF4842Montserrat.copyWith(
          color: AppColor.cFFFFFF,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _festivalSection() {
    return _sectionContainer(
      title: "Festival Details",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("Your Image"),
          UIHelper.verticalSpace(8.h),
          GestureDetector(onTap: pickMainImage, child: _uploadBox()),
          UIHelper.verticalSpace(16.h),
          _label("Festival"),
          UIHelper.verticalSpace(8.h),
          _festivalDropdown(),
          UIHelper.verticalSpace(16.h),
          Row(
            children: [
              Checkbox(
                side: BorderSide(color: AppColor.cFFFFFF),
                focusColor: AppColor.cFFFFFF,
                checkColor: AppColor.cFFFFFF,
                value: isSingleDay,
                onChanged: (val) => setState(() => isSingleDay = val!),
              ),
              Text(
                "Single Day",
                style: TextFontStyle.headline12w400cA7B0B9Montserrat.copyWith(
                  color: AppColor.cFFFFFF,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          if (isSingleDay) _datePickerField(),
          UIHelper.verticalSpace(16.h),
          _label("Location"),
          UIHelper.verticalSpace(8.h),
          _textField("Enter location", _location),
        ],
      ),
    );
  }

  Widget _experienceSection() {
    return _sectionContainer(
      title: "Your Experience",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("Favorite Set"),
          UIHelper.verticalSpace(8.h),
          _textField("e.g. The Blaze – Saturday Night", _favset),
          UIHelper.verticalSpace(16),
          _label("Favorite Day"),
          UIHelper.verticalSpace(8.h),
          _favouritday(),
          UIHelper.verticalSpace(16),
          _label("Camping Experience"),
          UIHelper.verticalSpace(8.h),
          _textField("Describe your camping experience...", _experience),
          UIHelper.verticalSpace(16),
          _label("Festival Story"),
          UIHelper.verticalSpace(8.h),
          _textField("Describe your festival experience...", _story),
        ],
      ),
    );
  }

  Widget _mediaSection() {
    return _sectionContainer(
      title: "Photos & Videos",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(onTap: pickMediaFiles, child: _uploadLargeBox()),
          const SizedBox(height: 8),
          const Text(
            "You can add captions to each photo after uploading.",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _privacySection() {
    return _sectionContainer(
      title: "Privacy",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              "Make Album Public\nAllow other users to view and comment on your album",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          Switch(
            value: isPublic,
            activeThumbColor: Colors.deepPurpleAccent,
            onChanged: (v) => setState(() => isPublic = v),
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: saveAlbum,
            child: const Text(
              "Save Album",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // UI Widgets
  // ============================================================

  Widget _sectionContainer({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1A191D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextFontStyle.headline16w700cFFFFFFMontserrat),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: TextFontStyle.headline12w400cA7B0B9Montserrat.copyWith(
      color: AppColor.cFFFFFF,
      fontSize: 14.sp,
    ),
  );

  Widget _textField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xff2A2A2E),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }

  Widget _datePickerField() {
    return TextField(
      controller: _datePicker,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration("dd/mm/yyyy").copyWith(
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          _datePicker.text = "${picked.year}-${picked.month}-${picked.day}";
        }
      },
    );
  }

  Widget _festivalDropdown() {
    return StreamBuilder<AllFestiveModel>(
      stream: allFestiveRxObj.dataFetcher.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _dropdownContainer(
            child: const Text(
              "Loading...",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        final list = snapshot.data!.data ?? [];

        return _dropdownContainer(
          child: DropdownButton<String>(
            value: selectedFestival,
            hint: const Text(
              "Select a festival",
              style: TextStyle(color: Colors.grey),
            ),
            dropdownColor: const Color(0xff2A2A2E),
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            items:
                list.map((f) {
                  return DropdownMenuItem(
                    value: f.festivalName,
                    child: Text(
                      f.festivalName ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
            onChanged: (v) {
              setState(() {
                selectedFestival = v;
                final f = list.firstWhere(
                  (element) => element.festivalName == v,
                );
                selectedFestivalId = f.id?.toString();
              });
            },
          ),
        );
      },
    );
  }

  Widget _uploadBox() {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child:
            mainImage == null
                ? const Text(
                  "Upload Your Image",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    mainImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
      ),
    );
  }

  Widget _uploadLargeBox() {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child:
            mediaFiles.isEmpty
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file, color: Colors.white, size: 40.sp),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: const Text(
                        "Browse Files",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
                : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      mediaFiles.map((file) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                file,
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            GestureDetector(
                              onTap:
                                  () => setState(() => mediaFiles.remove(file)),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
      ),
    );
  }

  Widget _dropdownContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _favouritday() {
    return _dropdownContainer(
      child: DropdownButton<String>(
        value: selectedDay,
        hint: const Text("Select a day", style: TextStyle(color: Colors.grey)),
        dropdownColor: const Color(0xff2A2A2E),
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        items:
            [
                  "saturday",
                  "sunday",
                  "monday",
                  "tuesday",
                  "wednesday",
                  "thursday",
                  "friday",
                ]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: const TextStyle(color: Colors.white)),
                  ),
                )
                .toList(),
        onChanged: (v) => setState(() => selectedDay = v),
      ),
    );
  }
}
