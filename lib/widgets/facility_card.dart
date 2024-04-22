import 'package:flutter/material.dart';

import '../model/models.dart';
import '../screens/screens.dart';

class FacilityCard extends StatefulWidget {
  const FacilityCard({super.key, required this.facility});

  final Facility facility;

  @override
  State<FacilityCard> createState() => _FacilityCardState();
}

class _FacilityCardState extends State<FacilityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => FaciltySchedule(
              facility: widget.facility,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.facility.name,
                  style:
                      const TextStyle(fontSize: 17, color: Colors.greenAccent),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Text('Tests offered', style: TextStyle(fontSize: 11)),
            const SizedBox(height: 5),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ListView.builder(
                itemBuilder: itemBuilder,
                itemCount: widget.facility.tests!.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                    ),
                    Text(
                      '${widget.facility.location[1]}, ${widget.facility.location[0]}',
                      style: const TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Center(
        child: Text(widget.facility.tests![index]),
      ),
    );
  }
}
