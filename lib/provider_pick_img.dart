import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickProvider with ChangeNotifier {
  String _downloadURL = '';

  String? get downloadURL => _downloadURL;

  File? _pickedImage;

  File? get pickedImage => _pickedImage;

  final ImagePicker _imagePicker = ImagePicker();

//----------------------------------------------------------------------
  Future<void> pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _pickedImage = File(image.path);

      try {
        // Upload to Firebase Storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().toIso8601String()}.png');
        final uploadTask = await ref.putFile(_pickedImage!);

        // Get the download URL
        _downloadURL = await uploadTask.ref.getDownloadURL();
      } catch (e) {
        // print('Error uploading image: $e');
      }

      notifyListeners();
    }
  }
//-----------------------------------------------------------------------

  // Хуллас Firebase да олдин расмни пост килиб кейин URL ни оларкан бошка иложи йук экан
  // яъни галарея ёки камерадан расмни олиши билан post булмаса URl создат килмаяпти

  void clearImage() {
    _pickedImage = null;
    notifyListeners();
  }
}
