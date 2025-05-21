import 'package:foco_led_app/models/device.dart';

class Light extends Device {
  Light({
    required String nombre,
    required bool estado,
    required String timestamp,
  }) : super(nombre: nombre, estado: estado, timestamp: timestamp);
}
