import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/widget/input_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/provider/user_places.dart';
import 'package:favourite_places/widget/input_image_picker.dart';

class AddFavouritePlace extends ConsumerStatefulWidget {
  const AddFavouritePlace({super.key});

  @override
  ConsumerState<AddFavouritePlace> createState() => _AddFavouritePlaceState();
}

class _AddFavouritePlaceState extends ConsumerState<AddFavouritePlace> {
  final _textEdittingController = TextEditingController();
  File? selectedImage;
  PlaceLocation? _selectedLocation;
  void savePlaces() {
    final addedPlace = _textEdittingController.text;
    if (addedPlace.isEmpty) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(Place(
        title: addedPlace,
        selectedImage: selectedImage!,
        location: _selectedLocation!));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Favourite Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _textEdittingController,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            InputImagePicker(
              selectedImage: ((image) => selectedImage = image),
            ),
            const SizedBox(
              height: 16,
            ),
            InputLocation(
              onSelectLocation: ((location) => _selectedLocation = location),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: savePlaces,
              icon: const Icon(Icons.add),
              label: Text(
                'Add Place',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
