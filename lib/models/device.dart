class Device {
  String nombre;
  bool estado;
  String timestamp;

  Device({required this.nombre, required this.estado, required this.timestamp});

  factory Device.fromMap(Map<dynamic, dynamic> map) {
    return Device(
      nombre: map['nombre'] ?? "Sin nombre",
      estado: map['estado'] ?? false,
      timestamp: map['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'nombre': nombre, 'estado': estado, 'timestamp': timestamp};
  }
}
