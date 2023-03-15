import 'package:flutter/material.dart';

class SpecialistCard extends StatefulWidget {
  const SpecialistCard({super.key});

  @override
  State<SpecialistCard> createState() => _SpecialistCardState();
}

class _SpecialistCardState extends State<SpecialistCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              CircleAvatar(backgroundColor: Color(0xFF0FA958)),
              Text(
                'Dr doc name',
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dermatologist',
                style: TextStyle(fontSize: 17, color: Color(0xFF4AC4AA)),
              ),
              Row(
                children: const [
                  Icon(Icons.location_on_rounded),
                  Text(
                    'Nairobi, kenya',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
