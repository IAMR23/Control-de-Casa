class Device {
  bool estado;
  String timestamp;

  Device({required this.estado, required this.timestamp});

  factory Device.fromMap(Map<dynamic, dynamic> map) {
    return Device(
      estado: map['estado'] ?? false,
      timestamp: map['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'estado': estado, 'timestamp': timestamp};
  }
}
