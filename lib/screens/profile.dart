import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../model/models.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int tab = 0;
  late User user;
  bool loading = true;

  @override
  void initState() {
    userRecords();
    super.initState();
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
              ? Alerts(user: user)
              : tab == 1
                  ? Tests(user: user)
                  : tab == 2
                      ? MySpecialist(user: user)
                      : Facilities(user: user),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          setState(() {
            tab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl_rounded),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_sharp),
            label: 'Specialist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_rounded),
            label: 'Facility',
          ),
        ],
      ),
    );
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
}
