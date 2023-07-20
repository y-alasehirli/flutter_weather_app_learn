import 'package:flutter/material.dart';

class UpdatedTimeWidget extends StatelessWidget {
  final DateTime updateTime;
  const UpdatedTimeWidget({
    required this.updateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime localizedTime = updateTime.toLocal();
    return Text("Son güncelleme : " +
        TimeOfDay.fromDateTime(localizedTime).format(context));
  }
}
