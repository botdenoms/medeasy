import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoPicker extends StatefulWidget {
  const GeoPicker({super.key});

  @override
  State<GeoPicker> createState() => _GeoPickerState();
}

class _GeoPickerState extends State<GeoPicker> {
  final nai = const LatLng(-1.28, 36.81);
  late final GoogleMapController _controller;
  LatLng? pick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(pick);
          },
          child: const Icon(Icons.chevron_left_rounded),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: nai,
          zoom: 14,
        ),
        mapType: MapType.normal,
        onMapCreated: (controller) {
          _controller = controller;
          Get.snackbar(
            'Success',
            'controller ${_controller.mapId} available',
            backgroundColor: Colors.greenAccent,
          );
        },
        onTap: (argument) {
          setState(() {
            pick = argument;
          });
          Get.snackbar(
            'Infor',
            '$argument',
            backgroundColor: Colors.blueAccent,
            duration: const Duration(seconds: 2),
          );
        },
      ),
    );
  }
}
