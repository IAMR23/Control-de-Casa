import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foco_led_app/models/device.dart';
import 'package:foco_led_app/models/device_factory.dart';

class HistorialWidget extends StatelessWidget {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child(
    'acciones',
  );

  Color _getColor(Device device) {
    return device.estado ? Colors.green.shade400 : Colors.red.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const Center(child: Text('No hay acciones registradas.'));
        }

        final data = Map<String, dynamic>.from(
          snapshot.data!.snapshot.value as Map,
        );
        final acciones =
            data.entries.map((entry) {
              final id = entry.key;
              final map = Map<String, dynamic>.from(entry.value);
              return deviceFactory(id, map);
            }).toList();

        acciones.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: acciones.length,
          itemBuilder: (context, index) {
            final accion = acciones[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: _getColor(accion)),
                title: Text(
                  accion.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${accion.estado ? "Activado" : "Desactivado"}\n${accion.timestamp}',
                  style: const TextStyle(height: 1.4),
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }
}
