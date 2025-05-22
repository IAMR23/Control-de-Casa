import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TemperatureService {
  final _ref = FirebaseDatabase.instance.ref('temperatura');
  bool _notificado = false;

  Stream<String> temperatureStream() {
    return _ref.onValue.map((event) {
      final valor = event.snapshot.value.toString();
      final doubleTemp = double.tryParse(valor) ?? 0;

      if (doubleTemp > 20) {
        if (!_notificado) {
          _mostrarNotificacionTemperatura(doubleTemp);
          _notificado = true;
        }
      } else {
        _notificado = false; // Resetea el estado si baja la temperatura
      }

      return valor;
    });
  }

  Future<void> _mostrarNotificacionTemperatura(double valor) async {
    const android = AndroidNotificationDetails(
      'temperatura_channel',
      'Alerta de Temperatura',
      channelDescription: 'Notificación cuando la temperatura es alta',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platform = NotificationDetails(android: android);

    await FlutterLocalNotificationsPlugin().show(
      0,
      '¡Temperatura alta!',
      'La temperatura ha subido a $valor °C',
      platform,
    );
  }

  Future<String> getTemperature() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }
}
