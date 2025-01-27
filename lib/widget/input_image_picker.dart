import 'package:flutter/material.dart';

class InputImagePicker extends StatefulWidget {
  const InputImagePicker({super.key});

  @override
  State<InputImagePicker> createState() => _InputImagePickerState();
}

class _InputImagePickerState extends State<InputImagePicker> {
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
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.camera),
        label: const Text('Take a picture'),
      ),
    );
  }
}
