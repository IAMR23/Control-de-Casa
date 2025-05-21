import 'package:foco_led_app/models/alarm.dart';
import 'package:foco_led_app/models/door.dart';
import 'package:foco_led_app/models/dry_control.dart';
import 'package:foco_led_app/models/light.dart';
import 'package:foco_led_app/models/mermaids.dart';
import 'package:foco_led_app/models/device.dart';

Device deviceFactory(String id, Map<String, dynamic> map) {
  final nombre = map['nombre'] ?? id;
  final estado = map['estado'] ?? false;
  final timestamp = map['timestamp'] ?? '';
  final tipo = map['tipo'] ?? ''; // Agrega este campo cuando guardes acciones

  switch (tipo) {
    case 'alarm':
      return Alarm(nombre: nombre, estado: estado, timestamp: timestamp);
    case 'door':
      return Door(nombre: nombre, estado: estado, timestamp: timestamp);
    case 'dry-control':
      return DryControl(nombre: nombre, estado: estado, timestamp: timestamp);
    case 'light':
      return Light(nombre: nombre, estado: estado, timestamp: timestamp);
    case 'mermaids':
      return Mermaids(nombre: nombre, estado: estado, timestamp: timestamp);
    default:
      return Device(nombre: nombre, estado: estado, timestamp: timestamp);
  }
}
