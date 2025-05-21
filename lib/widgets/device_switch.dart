import 'package:flutter/material.dart';

class DeviceSwitch extends StatelessWidget {
  final bool estado;
  final Function(bool) onChanged;

  const DeviceSwitch({Key? key, required this.estado, required this.onChanged})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(estado ? "On" : "Off"),
      value: estado,
      onChanged: onChanged,
    );
  }
}
