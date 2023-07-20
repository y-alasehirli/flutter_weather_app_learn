import 'package:flutter/material.dart';
import '/const/input_setts.dart';

class NowTempWidget extends StatelessWidget {
  final double temp;
  const NowTempWidget({
    required this.temp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          temp.toStringAsFixed(1),
          style: InputSetts.tempTStyle,
        ),
        const Text(" °C")
      ],
    );
  }
}
