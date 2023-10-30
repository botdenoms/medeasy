import 'package:flutter/material.dart';

import '../screens/screens.dart';
import '../model/models.dart';

class SpecialistCard extends StatefulWidget {
  const SpecialistCard({super.key, required this.specialist});
  final Specialist specialist;

  @override
  State<SpecialistCard> createState() => _SpecialistCardState();
}

class _SpecialistCardState extends State<SpecialistCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => SpecialistView(
              specialist: widget.specialist,
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
                ClipOval(
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: Image.network(
                      widget.specialist.profile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  widget.specialist.name,
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.specialist.speciality,
                  style:
                      const TextStyle(fontSize: 17, color: Color(0xFF4AC4AA)),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                    ),
                    Text(
                      '${widget.specialist.location[1]}, ${widget.specialist.location[0]}',
                      style: const TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(
                  Icons.star_outlined,
                  size: 18,
                  color: Colors.greenAccent,
                ),
                SizedBox(width: 5),
                Text(
                  '0.0',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
