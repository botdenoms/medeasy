import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class StatsCard extends StatefulWidget {
  const StatsCard({super.key, required this.specialist});
  final bool specialist;

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  int requests = 0;
  int schedules = 0;
  double ratingsAvg = 0;
  double ratedAvg = 0;
  DateTime? joined;
  DateTime? verifiedOn;

  @override
  void initState() {
    buildUserprofile();
    super.initState();
  }

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
              joined == null
                  ? "null"
                  : joined!
                      .toString()
                      .substring(0, joined.toString().length - 7),
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
              'Schedules made: ',
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
        const Divider(
          color: Color(0xFF1E1E1E),
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
                    verifiedOn == null
                        ? 'Not Verified'
                        : verifiedOn!
                            .toString()
                            .substring(0, joined.toString().length - 7),
                    style: TextStyle(
                      fontSize: 17,
                      color: verifiedOn == null
                          ? Colors.redAccent
                          : Colors.greenAccent,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 5),
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
        const SizedBox(height: 15),
        widget.specialist == true
            ? verifiedOn != null
                ? Row(
                    children: const [
                      Icon(Icons.add_location_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Add map address',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  )
                : const SizedBox()
            : const SizedBox(),
      ],
    );
  }

  buildUserprofile() async {
    // return infor on user
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    String userId = usr.user()!.uid;
    final resp = await fireCon.userData(userId);
    // resp.at == date
    final reqs = await fireCon.getAllRequestsMadeBy(userId);
    // reqs.length = made request
    final sch = await fireCon.getSchedulesOf(userId);
    // sch.length = schedules made
    if (widget.specialist) {
      final spe = await fireCon.specialistData(userId);
      if (spe!.verified) {
        setState(() {
          joined = resp!.at;
          requests = reqs!.length;
          schedules = sch!.length;
          verifiedOn = spe.at;
        });
      } else {
        setState(() {
          joined = resp!.at;
          requests = reqs!.length;
          schedules = sch!.length;
        });
      }
    } else {
      setState(() {
        joined = resp!.at;
        requests = reqs!.length;
        schedules = sch!.length;
      });
    }
  }
}
