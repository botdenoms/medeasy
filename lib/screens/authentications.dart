import 'package:flutter/material.dart';

import './screens.dart';

class Authentications extends StatefulWidget {
  const Authentications({super.key});

  @override
  State<Authentications> createState() => _AuthenticationsState();
}

class _AuthenticationsState extends State<Authentications> {
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
              const Text(
                'Join others already on the platform',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(hintText: 'Name'),
              ),
              const TextField(
                decoration: InputDecoration(hintText: '07...'),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Email@sm.com'),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'password'),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Have an account, log in',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Forgot the password!',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Account(),
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
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
