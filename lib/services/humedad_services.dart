import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HumedadService {
  final _ref = FirebaseDatabase.instance.ref('humedad');
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _notificado = false; // Para evitar notificaciones repetidas

  HumedadService() {
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initSettings = InitializationSettings(android: androidSettings);
    await _notificationsPlugin.initialize(initSettings);
  }

  Future<String> getHumedad() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }

  Stream<String> humedadStream() {
    return _ref.onValue.map((event) {
      final valorStr = event.snapshot.value.toString();
      final valorDouble = double.tryParse(valorStr) ?? 0;

      if (valorDouble > 70) {
        if (!_notificado) {
          _mostrarNotificacionHumedad(valorDouble);
          _notificado = true;
        }
      } else {
        _notificado = false; // Resetea para nuevas alertas si baja la humedad
      }

      return valorStr;
    });
  }

  Future<void> _mostrarNotificacionHumedad(double valor) async {
    const androidDetails = AndroidNotificationDetails(
      'humedad_channel',
      'Alerta de Humedad',
      channelDescription: 'Notificación cuando la humedad es alta',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      4,
      '¡Humedad alta!',
      'La humedad actual es $valor%',
      platformDetails,
    );
  }
}
