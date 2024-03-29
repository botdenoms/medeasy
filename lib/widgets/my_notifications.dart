import 'package:flutter/material.dart';
import 'package:medeasy/widgets/widgets.dart';

import '../model/models.dart';
import 'package:get/get.dart';
import 'package:medeasy/controllers/controllers.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key, required this.user});
  final User user;

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  bool loading = true;
  List<Request> notificactions = [];
  late String userId;

  notifications() async {
    final FireStoreController fireCon = Get.find();
    final UserController usr = Get.find();
    userId = usr.user()!.uid;
    final resp = await fireCon.getRequestsOf(usr.user()!.uid);
    setState(() {
      notificactions = resp!;
      loading = false;
    });
  }

  @override
  void initState() {
    notifications();
    super.initState();
  }

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
                      child: Icon(
                        Icons.account_circle_outlined,
                      ),
                    ),
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'My notifications',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Filter by: ',
                  style: TextStyle(fontSize: 14, color: Colors.greenAccent),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : notificactions.isEmpty
                    ? const Center(
                        child: Text('No Notifications for you'),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => RequestCard(
                          request: notificactions[index],
                          specialist: widget.user.specialist!,
                          userId: userId,
                        ),
                        itemCount: notificactions.length,
                      ),
          ),
        ],
      ),
    );
  }
}
