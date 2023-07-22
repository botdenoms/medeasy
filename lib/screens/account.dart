import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../model/models.dart';

import 'package:get/get.dart';
import 'package:medeasy/controllers/controllers.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int tab = 0;
  bool loading = true;
  late User user;

  @override
  void initState() {
    userRecords();
    super.initState();
  }

  void userRecords() async {
    final UserController userCon = Get.find();
    final FireStoreController fireCon = Get.find();
    String? id = userCon.user()!.uid;
    User? usr = await fireCon.userData(id);
    setState(() {
      user = usr!;
      loading = false;
    });
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
        actions: [
          IconButton(
            onPressed: () {
              // log out
              final UserController userCon = Get.find();
              userCon.logOut();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.logout_rounded,
              size: 28,
              color: Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black38),
            )
          : tab == 0
              ? MyScehdule(
                  user: user,
                )
              : tab == 1
                  ? MyNotifications(
                      user: user,
                    )
                  : MySpecialist(
                      user: user,
                    ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        selectedItemColor: Colors.greenAccent,
        onTap: (index) {
          setState(() {
            tab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety_rounded),
            label: 'Specialist',
          ),
        ],
      ),
    );
  }
}
