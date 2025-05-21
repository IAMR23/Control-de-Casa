import 'package:foco_led_app/models/device.dart';

class DryControl extends Device {
  DryControl({required bool estado, required String timestamp})
    : super(estado: estado, timestamp: timestamp);
}
