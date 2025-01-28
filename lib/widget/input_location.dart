import 'package:flutter/material.dart';
import 'package:location/location.dart';

class InputLocation extends StatefulWidget {
  const InputLocation({super.key});

  @override
  State<InputLocation> createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  Location? userLocation;
  var isGetting = false;

  void getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGetting = true;
    });

    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    setState(() {
      isGetting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? optionalWidget;
    optionalWidget = optionalWidget = TextButton.icon(
      onPressed: getUserLocation,
      label: const Text('Select User location'),
      icon: const Icon(Icons.location_on),
    );

    if (isGetting) {
      optionalWidget = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
          height: 160,
          width: double.infinity,
          child: Text(
            'No location found yet.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.surface),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            optionalWidget,
            TextButton.icon(
              onPressed: () {},
              label: const Text('Open the Map'),
              icon: const Icon(Icons.map),
            ),
          ],
        )
      ],
    );
  }
}
