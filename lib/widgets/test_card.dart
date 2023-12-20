import 'package:flutter/material.dart';

import '../configs/constants.dart';
import '../model/models.dart';
import '../screens/screens.dart';

class TestCard extends StatefulWidget {
  const TestCard({
    super.key,
    required this.test,
    required this.view,
  });
  final Test test;
  final bool view;

  @override
  State<TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.view) {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => TestView(test: widget.test),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => TestForm(test: widget.test),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.test.date.toString().substring(0, 11)),
            Text(tests[widget.test.type]),
          ],
        ),
      ),
    );
  }
}
