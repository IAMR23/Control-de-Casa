import 'package:foco_led_app/models/device.dart';

class Alarm extends Device {
  Alarm({required bool estado, required String timestamp})
    : super(estado: estado, timestamp: timestamp);
}
