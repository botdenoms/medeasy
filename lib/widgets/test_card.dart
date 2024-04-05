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
            Text(
              formatDate(widget.test.date),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.greenAccent,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Type: ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  tests[widget.test.type],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime dt) {
    String day = '';
    String month = '';
    switch (dt.day) {
      case 1:
        day = '1st';
        break;
      case 2:
        day = '2nd';
        break;
      case 3:
        day = '3rd';
        break;
      default:
        day = '${dt.day}th';
    }
    switch (dt.month) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'Octorber';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
      default:
        break;
    }
    return '$day $month, ${dt.year}';
  }
}
