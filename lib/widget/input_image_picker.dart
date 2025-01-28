import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImagePicker extends StatefulWidget {
  const InputImagePicker({super.key, required this.selectedImage});
  final void Function(File) selectedImage;
  @override
  State<InputImagePicker> createState() => _InputImagePickerState();
}

class _InputImagePickerState extends State<InputImagePicker> {
  File? pickedImage;
  void _takePicture() async {
    var imagePicker = ImagePicker();
    try {
      final XFile? selectedImage = await imagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 600);

      if (selectedImage == null) {
        return;
      }
      setState(() {
        pickedImage = File(selectedImage.path);
      });
      widget.selectedImage(pickedImage!);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
      ),
      width: double.infinity,
      alignment: Alignment.center,
      child: pickedImage != null
          ? GestureDetector(
              onTap: _takePicture,
              child: Image.file(
                pickedImage!,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : TextButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take a picture'),
            ),
    );
  }
}
