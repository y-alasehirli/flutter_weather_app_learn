import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String stateAbbr;
  const ImageWidget({required this.stateAbbr, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imageUrl =
        "https://www.metaweather.com/static/img/weather/png/$stateAbbr.png";
    return Image.network(
      _imageUrl,
      scale: 4,
    );
  }
}
