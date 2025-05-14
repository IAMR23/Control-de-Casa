import 'package:flutter/material.dart';

class LightSwitch extends StatelessWidget {
  final bool encendido;
  final Function(bool) onChanged;

  const LightSwitch({
    Key? key,
    required this.encendido,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(encendido ? 'Encendido' : 'Apagado'),
      value: encendido,
      onChanged: onChanged,
    );
  }
}
