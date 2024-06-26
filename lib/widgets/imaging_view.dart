import 'package:flutter/material.dart';

import '../model/models.dart';

class ImagingData extends StatefulWidget {
  const ImagingData({super.key, required this.imagingData});
  final ImagingTest imagingData;

  @override
  State<ImagingData> createState() => _ImagingDataState();
}

class _ImagingDataState extends State<ImagingData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: imageBuilder,
          itemCount: widget.imagingData.images.length,
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget? imageBuilder(BuildContext context, int index) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.network(
        widget.imagingData.images[index],
      ),
    );
  }
}
