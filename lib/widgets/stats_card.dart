import 'package:flutter/material.dart';

class StatsCard extends StatefulWidget {
  const StatsCard({super.key, required this.specialist});
  final bool specialist;

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  int requests = 0;
  int schedules = 0;
  double ratingsAvg = 2.5;
  double ratedAvg = 2.5;
  DateTime? joined;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              "Joined on:",
              style: TextStyle(fontSize: 17, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(width: 5),
            Text(
              joined == null ? "null" : joined!.toString(),
              style: const TextStyle(fontSize: 17, color: Colors.greenAccent),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text(
              'Requests made: ',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(width: 5),
            Text(
              requests.toString(),
              style: const TextStyle(fontSize: 17, color: Colors.greenAccent),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text(
              'Schedules Appoinments: ',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(width: 5),
            Text(
              schedules.toString(),
              style: const TextStyle(fontSize: 17, color: Colors.greenAccent),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text(
              'Ratings Average: ',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(width: 5),
            Text(
              ratingsAvg.toString(),
              style: const TextStyle(fontSize: 17, color: Colors.greenAccent),
            ),
          ],
        ),
        const SizedBox(height: 5),
        widget.specialist == true
            ? Row(
                children: [
                  const Text(
                    'Verified on: ',
                    style: TextStyle(fontSize: 17, color: Color(0xFF1E1E1E)),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    joined == null ? 'null' : joined!.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        widget.specialist == true
            ? Row(
                children: [
                  const Text(
                    'Rated Average: ',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ratedAvg.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
