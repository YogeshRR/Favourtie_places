import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:favourite_places/models/place.dart';

class InputLocation extends StatefulWidget {
  const InputLocation({super.key});

  @override
  State<InputLocation> createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  Widget? optionalWidget;
  PlaceLocation? userLocation;
  var isGetting = false;
  ScreenshotController screenshotController = ScreenshotController();
  LocationData? localLocationData;

  void getUserLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
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
    localLocationData = locationData;
    final String address = await getAddress(
      locationData.latitude ?? 0.0,
      locationData.longitude ?? 0.0,
    );
    print(address);
    final image = await screenshotController.capture();
    setState(() {
      userLocation = PlaceLocation(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
          address: address);

      isGetting = false;
    });
  }

  Future<String> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String? address =
          "${place.street},${place.locality},${place.country},${place.postalCode}";
      return address;
    } catch (error) {
      print(error.toString());
      return 'Error occurred';
    }
  }

  @override
  Widget build(BuildContext context) {
    optionalWidget = TextButton.icon(
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
          child: !isGetting
              ? Screenshot(
                  controller: screenshotController,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(localLocationData?.latitude ?? 0.000,
                          localLocationData?.longitude ?? 0.000),
                      zoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(localLocationData?.latitude ?? 0.000,
                                localLocationData?.longitude ?? 0.000),
                            builder: (context) => const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              //size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            optionalWidget!,
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
