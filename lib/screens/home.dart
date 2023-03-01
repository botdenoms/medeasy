import 'package:flutter/material.dart';
import 'package:medeasy/screens/screens.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Medeasy',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.account_circle,
              size: 36,
              color: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.troubleshoot_rounded, size: 32),
                        Text('20, 000', style: TextStyle(fontSize: 22))
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text('Test done', style: TextStyle(fontSize: 12))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.people, size: 32),
                        Text('200', style: TextStyle(fontSize: 22))
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Registered specialist',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.schedule_rounded, size: 32),
                    Text('20', style: TextStyle(fontSize: 22))
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  'Scheduled Appointments',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            //const SizedBox(height: 40),
            const Spacer(),
            const Text(
                'Are you curious about your state of mental health!, Take our Quick online diagnosis test using our app.',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B3B3B),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'Diagnosis',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
                'Sign up and join other specialist on our platform and gain access to more people seeking your help online or physically.',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0FA984),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => const Diagnosis(),
          ));
        },
        tooltip: 'Schedule an appointment',
        backgroundColor: const Color(0xFF0FA958),
        child: const Icon(Icons.schedule, size: 36),
      ),
    );
  }
}
