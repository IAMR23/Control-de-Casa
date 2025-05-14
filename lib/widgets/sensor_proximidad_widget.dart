import 'package:flutter/material.dart';
import 'package:foco_led_app/services/proximidad_services.dart';

class SensorProximidadWidget extends StatelessWidget {
  final ProximidadService _service = ProximidadService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.near_me_rounded, size: 40),
        const Text('Proximidad', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        StreamBuilder<String>(
          stream: _service.proximidadStream(),
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
