import 'package:flutter/material.dart';

import '../model/models.dart';
import '../widgets/widgets.dart';

class PendingTests extends StatefulWidget {
  const PendingTests({super.key, required this.tests});
  final List<Test> tests;

  @override
  State<PendingTests> createState() => _PendingTestsState();
}

class _PendingTestsState extends State<PendingTests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Tests',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (c, i) => TestCard(
                test: widget.tests[i],
                view: false,
              ),
              itemCount: widget.tests.length,
            ),
          ),
        ],
      ),
    );
  }
}
