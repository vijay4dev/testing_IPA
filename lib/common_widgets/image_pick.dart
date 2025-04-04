import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> showImagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    return await showModalBottomSheet<File?>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text("Camera"),
              onTap: () async {
                final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
                Navigator.pop(context, pickedFile != null ? File(pickedFile.path) : null);
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: Colors.green),
              title: Text("Gallery"),
              onTap: () async {
                final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                Navigator.pop(context, pickedFile != null ? File(pickedFile.path) : null);
              },
            ),
          ],
        );
      },
    );
  }
}
