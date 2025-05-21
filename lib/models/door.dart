import 'package:foco_led_app/models/device.dart';

class Door extends Device {
  Door({required bool estado, required String timestamp})
    : super(estado: estado, timestamp: timestamp);
}
