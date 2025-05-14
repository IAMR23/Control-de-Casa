class Light {
  bool estado;
  String timestamp;

  Light({required this.estado, required this.timestamp});

  factory Light.fromMap(Map<dynamic, dynamic> map) {
    return Light(
      estado: map['estado'] ?? false,
      timestamp: map['timestamp'] ?? '',
    );
  }
}
