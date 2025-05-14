import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/light.dart';

class HistorialWidget extends StatelessWidget {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child(
    'acciones',
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Center(child: Text('No hay acciones registradas.'));
        }

        final data = Map<String, dynamic>.from(
          snapshot.data!.snapshot.value as Map,
        );

        // Convertir los datos a una lista de objetos
        final acciones =
            data.entries.map((entry) {
              return Light.fromMap(Map<String, dynamic>.from(entry.value));
            }).toList();

        // Ordenar por fecha descendente (reciente primero)
        acciones.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return ListView.builder(
          itemCount: acciones.length,
          itemBuilder: (context, index) {
            final accion = acciones[index];
            return ListTile(
              leading: Icon(
                accion.estado ? Icons.lightbulb : Icons.lightbulb_outline,
                color: accion.estado ? Colors.yellow : Colors.grey,
              ),
              title: Text(accion.estado ? 'Encendido' : 'Apagado'),
              subtitle: Text(accion.timestamp),
            );
          },
        );
      },
    );
  }
}
