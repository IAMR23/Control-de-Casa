import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class IncendioService {
  final _ref = FirebaseDatabase.instance.ref('sensor/incendio');
  bool _notificado = false;

  Stream<String> incendioStream() {
    return _ref.onValue.map((event) {
      final valor = event.snapshot.value.toString().toLowerCase();

      if (valor == 'activo' && !_notificado) {
        _mostrarNotificacionIncendio();
        _notificado = true;
      } else if (valor != 'activo') {
        _notificado = false; // Resetea si ya no está activo
      }

      return valor;
    });
  }

  Future<void> _mostrarNotificacionIncendio() async {
    const android = AndroidNotificationDetails(
      'incendio_channel',
      'Alerta de Incendio',
      channelDescription: 'Notificación cuando se detecta un incendio',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platform = NotificationDetails(android: android);

    await FlutterLocalNotificationsPlugin().show(
      2,
      '🔥 ¡Alerta de Incendio!',
      'Se ha detectado humo o fuego en el ambiente.',
      platform,
    );
  }

  Future<String> getIncendioEstado() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }
}
