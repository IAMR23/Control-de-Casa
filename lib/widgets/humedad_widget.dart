import 'package:flutter/material.dart';
import 'package:foco_led_app/services/humedad_services.dart';

class HumedadWidget extends StatelessWidget {
  final HumedadService _service = HumedadService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.water_damage_rounded, size: 40),
        const Text('Humedad', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        StreamBuilder<String>(
          stream: _service.humedadStream(),
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
