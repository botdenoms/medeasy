import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({super.key});

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        itemBuilder(context, 0),
        itemBuilder(context, 1),
        itemBuilder(context, 2),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Container(
      color: Colors.black38,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("00:00"),
            const Text("00:00"),
            Container(
              color: Colors.greenAccent,
              child: const Center(
                child: Text('available'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
