import 'package:flutter/material.dart';

class LuzWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.file_download_done, size: 40),
        const Text('Humedad', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        /*   StreamBuilder<String>(
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
        ), */
      ],
    );
  }
}
