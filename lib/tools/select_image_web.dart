import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

Future<Uint8List?> selectImage() async {
  final imageData = await ImagePickerWeb.getImageAsBytes();
  return imageData;
}
