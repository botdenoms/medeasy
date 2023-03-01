import 'package:flutter/material.dart';

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          decoration: InputDecoration(
              hintText: 'Age',
              filled: true,
              fillColor: Color(0xFF1E1E1E),
              hintStyle: TextStyle(fontSize: 17, color: Colors.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border:  OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text(
          'Gender',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'Male',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'Female',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Any history of mental illness in your family? ',
          style: TextStyle(fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'YES',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'NO',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
