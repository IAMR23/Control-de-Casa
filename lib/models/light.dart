import 'package:foco_led_app/models/device.dart';

class Light extends Device {
  final String id;
  final String nombre;
  final String ubicacion;

  Light({
    required this.id,
    required this.nombre,
    required this.ubicacion,
    required bool estado,
    required String timestamp,
  }) : super(estado: estado, timestamp: timestamp);

  factory Light.fromMap(String id, Map<dynamic, dynamic> map) {
    return Light(
      id: id,
      nombre: map['nombre'] ?? 'Sin nombre',
      ubicacion: map['ubicacion'] ?? 'desconocida',
      estado: map['estado'] ?? false,
      timestamp: map['timestamp'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'ubicacion': ubicacion,
      'estado': estado,
      'timestamp': timestamp,
    };
  }
}
