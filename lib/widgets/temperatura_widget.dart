import 'package:flutter/material.dart';
import 'package:foco_led_app/services/temperatura_services.dart';

class TemperaturaWidget extends StatelessWidget {
  final TemperatureService _service = TemperatureService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.thermostat, size: 40),
        const Text('Temperatura', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        StreamBuilder<String>(
          stream: _service.temperatureStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Error');
            }
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${snapshot.data} °C',
                style: const TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      ],
    );
  }
}
