import 'package:flutter/material.dart';

import './screens.dart';

class SpecialistView extends StatefulWidget {
  const SpecialistView({super.key});

  @override
  State<SpecialistView> createState() => _SpecialistViewState();
}

class _SpecialistViewState extends State<SpecialistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  CircleAvatar(radius: 28, backgroundColor: Colors.amber),
                  Text(
                    'Verified',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Dr Doc Name', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Dermatologist', style: TextStyle(fontSize: 16)),
                  Text('Nairobi, Kenya', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Calendar', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Schedule(),
                  ));
                },
                child: Container(
                  height: 200,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
