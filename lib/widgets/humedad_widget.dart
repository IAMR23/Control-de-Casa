import 'package:flutter/material.dart';
import 'package:foco_led_app/services/humedad_services.dart';

class HumedadWidget extends StatelessWidget {
  final HumedadService _service = HumedadService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.water_damage_rounded, size: 40, color: Colors.blue),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Humedad',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              StreamBuilder<String>(
                stream: _service.humedadStream(),
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
                    '${snapshot.data} %',
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
