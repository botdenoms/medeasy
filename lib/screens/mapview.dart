import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medeasy/model/models.dart';
import 'package:medeasy/screens/screens.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../configs/constants.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.specialists});
  final List<Specialist> specialists;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final GoogleMapController _controller;
  TextEditingController searchCon = TextEditingController();

  final nai = const LatLng(-1.28, 36.81);
  Set<Marker> mrks = {};
  Set<Circle> home = {};
  bool working = false;
  bool details = false;
  int index = 0;

  List<Specialist> filtered = [];

  @override
  void initState() {
    filtered = widget.specialists;
    buildMakers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: nai,
                zoom: 14,
              ),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                _controller = controller;
              },
              markers: mrks,
              onTap: (argument) {
                details = false;
                FocusScope.of(context).unfocus();
                setState(() {});
              },
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 10,
            right: 10,
            child: details
                ? Material(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    elevation: 2,
                    shadowColor: const Color.fromARGB(174, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filtered[index].name,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            filtered[index].speciality,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    details = false;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  //  move to a specialist screen
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          SpecialistView(
                                        specialist: filtered[index],
                                      ),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueAccent),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text(
                                  'Request',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        goHome();
                      },
                      child: const Icon(Icons.home_filled),
                    ),
                  ),
          ),
          SizedBox(
            width: size.width,
            height: size.height,
            child: working
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  )
                : const SizedBox(),
          ),
          Positioned(
            top: 20.0,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.remove_red_eye_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Material(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  elevation: 2,
                  shadowColor: const Color.fromARGB(174, 0, 0, 0),
                  child: SearchField<String>(
                    suggestions: suggestionSpecialists.map((e) {
                      return SearchFieldListItem<String>(e,
                          item: e,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ));
                    }).toList(),
                    controller: searchCon,
                    searchInputDecoration: const InputDecoration(
                      hintText: 'Specialist',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                    ),
                    onSubmit: (text) {
                      FocusScope.of(context).unfocus();
                      search(text);
                    },
                    onSuggestionTap: (listItem) {
                      FocusScope.of(context).unfocus();
                      search(listItem.item!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildMakers() {
    //  loop through filtered list add marker obj to markers set
    List<Marker> t = [];
    for (var element in filtered) {
      if (element.geo != null) {
        Marker mkr = Marker(
          markerId: MarkerId(element.id),
          position: element.geo!,
          consumeTapEvents: true,
          onTap: () {
            // show details widget
            index = filtered.indexOf(element);
            details = true;
            setState(() {});
          },
        );
        t.add(mkr);
      }
    }
    mrks.clear();
    mrks.addAll(t);
    setState(() {});
  }

  addHomeMarker(LatLng coord) {
    Circle cirl = Circle(
      circleId: CircleId(coord.toString()),
      center: coord,
      radius: 1,
    );
    home.add(cirl);
    setState(() {});
  }

  goHome() async {
    if (working) {
      return;
    }
    if (await Permission.location.isDenied) {
      return;
    }
    // navigate to user location
    // get user location
    setState(() {
      working = true;
    });
    try {
      Position current = await Geolocator.getCurrentPosition();
      Get.snackbar(
        'Success',
        'Current: ${current.toString()}',
        backgroundColor: Colors.blueAccent,
      );
      setState(() {
        working = false;
      });
      await _controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            current.latitude,
            current.longitude,
          ),
        ),
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        'Current: ${error.toString()}',
        backgroundColor: Colors.redAccent,
      );
    }
  }

  search(String searchText) {
    if (searchText == '') {
      filtered = widget.specialists;
      buildMakers();
      setState(() {});
      return;
    }
    setState(() {
      working = true;
    });
    List<Specialist> tmp = [];
    // Filter list with specialist that match the text
    for (var element in widget.specialists) {
      if (element.speciality == searchText) {
        tmp.add(element);
      }
    }
    filtered = tmp;
    buildMakers();
    setState(() {
      working = false;
    });
  }
}
