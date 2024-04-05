import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import '../widgets/widgets.dart';

class Facilities extends StatefulWidget {
  const Facilities({super.key});

  @override
  State<Facilities> createState() => _FacilitiesState();
}

class _FacilitiesState extends State<Facilities> {
  bool loading = true;
  List<Facility> facilities = [];

  @override
  void initState() {
    fetchFacilities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    CircleAvatar(
                      // radius: 28,
                      child: Icon(
                        Icons.search_rounded,
                      ),
                    ),
                    Text(
                      "Search ...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Facilities',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: LinearProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (c, i) => FacilityCard(
                      facility: facilities[i],
                    ),
                    itemCount: facilities.length,
                  ),
          ),
        ],
      ),
    );
  }

  fetchFacilities() async {
    setState(() {
      loading = true;
    });
    final FireStoreController fireCon = Get.find();
    final resp = await fireCon.getVerifiedFacilities();
    setState(() {
      facilities = resp!;
      loading = false;
    });
  }
}
