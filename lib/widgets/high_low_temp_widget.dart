import 'package:flutter/material.dart';

class HighLowTempWidget extends StatelessWidget {
  final double maxTemp;
  final double minTemp;
  const HighLowTempWidget(
      {required this.maxTemp, required this.minTemp, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Max. Sıcaklık : "+maxTemp.toStringAsFixed(1)+ " °C"),
          Text("Min. Sıcaklık : "+minTemp.toStringAsFixed(1)+ " °C"),
        ],
      ),
    );
  }
}
