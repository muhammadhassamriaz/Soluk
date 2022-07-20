import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class Pickers {
  static final instance = Pickers._internal();
  Pickers._internal();
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImage(
      {ImageSource source = ImageSource.camera,
      int quality = 50,
      CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
    try {
      XFile? file = await _picker.pickImage(
          source: source,
          imageQuality: quality,
          preferredCameraDevice: preferredCameraDevice);
      return file?.path;
    } catch (e) {
      //print(e);
      return null;
    }
  }

  static const List<String> _allowedExtensions = [
    'bmp',
    'doc',
    'docx',
    'gif',
    'jpeg',
    'jpg',
    'pdf',
    'png',
    'tif',
    'tiff',
    'xls',
    'xlsx'
  ];
  Future<FilePickerResult?> pickFile(
      {FileType type = FileType.custom,
      List<String> allowedExtensions = _allowedExtensions,
      bool allowCompression = true,
      bool allowMultiple = false}) async {
    try {
      return await FilePicker.platform.pickFiles(
          type: type,
          allowedExtensions: allowedExtensions,
          allowCompression: allowCompression,
          allowMultiple: allowMultiple);
    } catch (e) {
      return null;
    }
  }
}
