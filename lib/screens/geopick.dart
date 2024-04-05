import 'package:flutter/material.dart';
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
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(pick);
          },
          child: const Icon(
            Icons.chevron_left_rounded,
            color: Color(0xFF1E1E1E),
          ),
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
        },
        onTap: (argument) {
          setState(() {
            pick = argument;
            Marker mkr = Marker(
              markerId: MarkerId(_controller.toString()),
              position: argument,
            );
            markers.add(mkr);
          });
        },
        markers: markers,
      ),
    );
  }
}
