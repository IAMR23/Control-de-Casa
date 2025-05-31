import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LluviaService {
  final _ref = FirebaseDatabase.instance.ref('sensor/lluvia');
  bool _notificado = false;

  Stream<String> lluviaStream() {
    return _ref.onValue.map((event) {
      final valor = event.snapshot.value.toString().toLowerCase();

      if (valor == 'activo' && !_notificado) {
        _mostrarNotificacionLluvia();
        _notificado = true;
      } else if (valor != 'activo') {
        _notificado = false; // Resetea si ya no está activo
      }

      return valor;
    });
  }

  Future<void> _mostrarNotificacionLluvia() async {
    const android = AndroidNotificationDetails(
      'lluvia_channel',
      'Alerta de Lluvia',
      channelDescription: 'Notificación cuando se detecta presencia de lluvia',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platform = NotificationDetails(android: android);

    await FlutterLocalNotificationsPlugin().show(
      3,
      '🌧️ ¡Alerta de Lluvia!',
      'Se ha detectado presencia de lluvia en el ambiente.',
      platform,
    );
  }

  Future<String> getLluviaEstado() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }
}
