import 'dart:io';

import 'package:flutter/material.dart';

class ImageForm extends StatefulWidget {
  const ImageForm({
    super.key,
    required this.img,
    required this.pathUrl,
  });
  final bool img;
  final String pathUrl;

  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: widget.img
              ? Image.file(File(widget.pathUrl))
              : const Center(
                  child: Text('No Image added'),
                ),
        ),
      ],
    );
  }
}
