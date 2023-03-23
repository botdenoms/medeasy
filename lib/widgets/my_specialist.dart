import 'package:flutter/material.dart';

import '../screens/screens.dart';
import '../model/models.dart';

class MySpecialist extends StatefulWidget {
  const MySpecialist({super.key, required this.user});
  final User user;
  @override
  State<MySpecialist> createState() => _MySpecialistState();
}

class _MySpecialistState extends State<MySpecialist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.amber,
                    ),
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: widget.user.specialist == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Create a specialist',
                          style: TextStyle(fontSize: 15),
                        ),
                        const Text(
                          'account',
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const Registration(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                  10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E1EEE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'to be developed',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'specialist account',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
