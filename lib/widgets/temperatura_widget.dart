import 'package:flutter/material.dart';
import 'package:foco_led_app/services/temperatura_services.dart';

class TemperaturaWidget extends StatelessWidget {
  final TemperatureService _service = TemperatureService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade100,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.thermostat, size: 40, color: Colors.deepOrange),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Temperatura',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              StreamBuilder<String>(
                stream: _service.temperatureStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'Cargando...',
                      style: TextStyle(fontSize: 14),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text(
                      'Error',
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    );
                  }
                  return Text(
                    '${snapshot.data} °C',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
