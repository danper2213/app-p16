import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  Utils._();

  static Future<XFile?> selectImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  static Future<CroppedFile?> cropSelectedImage(String filePath) async {
    return await ImageCropper().cropImage(sourcePath: filePath,
        //aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 1.0),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cortar Imagen',
          toolbarColor: ColorCustom.marineBlue,
          backgroundColor: ColorCustom.marineBlue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    ]);
  }
}
