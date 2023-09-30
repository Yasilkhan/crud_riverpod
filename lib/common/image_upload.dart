import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
//
// class ImageGetUpload {

  // String ImageUrl = "";
  // late XFile photo;
  // File? image;
  //
  // final picker = ImagePicker();
  //
  //
  //
  // Future getImager() async {
  //   var pickImage = await picker.pickImage(source: ImageSource.gallery);
  //
  //
  //     if (pickImage != null) {
  //       image = File(pickImage.path);
  //     } else {
  //       print("no image selected");
  //     }
  //
  // }
  //
  // Future uploadImage() async {
  //   getImager();
  //   String uniquefilename = DateTime
  //       .now()
  //       .microsecondsSinceEpoch
  //       .toString();
  //
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference referenceDirImages = referenceRoot.child('pics/');
  //   Reference referenceImagetoUpload = referenceDirImages.child(uniquefilename);
  //
  //   await referenceImagetoUpload.putFile(File(image!.path));
  //   var downloadUrl = await (referenceImagetoUpload).getDownloadURL();
  //   print(downloadUrl);
  //
  //   ImageUrl = downloadUrl;
  //   print(ImageUrl);
  //
  // }

// }


class FirebaseImageUploader {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  FirebaseImageUploader(Future imager);

  Future<String?> pickAndUploadImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        return null;
      }
      File file = File(pickedFile.path);
      String ImageUrl = await _uploadFile(file);
      return ImageUrl;
    } catch (e) {
      print('Error picking and uploading image: $e');
      return null;
    }
  }

  Future<String> _uploadFile(File file) async {
    try {

      Reference storageReference = _storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
      await storageReference.putFile(file);
      String ImageUrl = await storageReference.getDownloadURL();
      return ImageUrl;
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }
}
