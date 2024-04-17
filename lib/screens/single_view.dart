import 'package:flutter/material.dart';

class SingleViewer extends StatefulWidget {
  const SingleViewer({super.key});

  @override
  State<SingleViewer> createState() => _SingleViewerState();
}

class _SingleViewerState extends State<SingleViewer> {
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
            onPressed: () {},
            icon: const Icon(
              Icons.download_rounded,
              color: Color(0xFF1E1E1E),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_rounded,
              color: Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }
}
