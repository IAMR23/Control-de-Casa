import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RoboService {
  final _ref = FirebaseDatabase.instance.ref('sensor/robo');
  bool _notificado = false;

  Stream<String> roboStream() {
    return _ref.onValue.map((event) {
      final valor = event.snapshot.value.toString().toLowerCase();

      if (valor == 'activado' && !_notificado) {
        _mostrarNotificacionRobo();
        _notificado = true;
      } else if (valor != 'activado') {
        _notificado = false; // Resetea si ya no está activa
      }

      return valor;
    });
  }

  Future<void> _mostrarNotificacionRobo() async {
    const android = AndroidNotificationDetails(
      'robo_channel',
      'Alerta de Robo',
      channelDescription: 'Notificación cuando se detecta un robo',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platform = NotificationDetails(android: android);

    await FlutterLocalNotificationsPlugin().show(
      1,
      '🚨 ¡Alerta de Robo!',
      'Se ha detectado una posible intrusión en el sistema.',
      platform,
    );
  }

  Future<String> getRoboEstado() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }
}
