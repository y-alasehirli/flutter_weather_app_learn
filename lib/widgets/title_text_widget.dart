import 'package:flutter/material.dart';
import 'package:flutter33_hava_durumu_app/const/input_setts.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: InputSetts.titleTStyle,
    );
  }
}